require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  # validな従業員をセットアップする。
  def setup
    @employee = Employee.new(
      name: "Example Employee",
      email: "employee@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "should be valid" do
    assert @employee.valid?
  end
  
  # 各種パラメータを不正な値に更新して、invalidであるかをテストする。
  test "name should be present" do
    @employee.name = "     "
    assert_not @employee.valid?
  end
  test "email should be present" do 
    @employee.email = "     "
    assert_not @employee.valid?
  end
  test "name should not be too long" do
    @employee.name = "a" * 51
    assert_not @employee.valid?
  end
  test "email should not be too long" do
    @employee.email = "a" * 244 + "@example.com"
    assert_not @employee.valid?
  end
  test "email addresses should be unique" do
    duplicate_employee = @employee.dup
    @employee.save
    assert_not duplicate_employee.valid?
  end
  test "password should be present (nonblank)" do
    @employee.password = @employee.password_confirmation = " " * 6
    assert_not @employee.valid?
  end
  test "password should have a minimum length" do
    @employee.password = @employee.password_confirmation = "a" * 5
    assert_not @employee.valid?
  end
  
  # メールアドレスの形式をチェックする。
  test "email validation should accept valid addresses" do
    valid_addresses = %w[employee@example.com EMPLOYEE@foo.COM A_EM-PLOEE@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @employee.email = valid_address
      assert @employee.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @employee.email = invalid_address
      assert_not @employee.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  # ブラウザ１でログアウト（クッキーの削除）した後、ブラウザ２でタブを再起動した場合のテスト。
  # つまり、cookiesのリメンバートークンとDBのリメンバーダイジェストを比較した際にエラーが出るかを確認する。
  test "authenticated? should return false for a employee with nil digest" do
    assert_not @employee.authenticated?('')
  end
  
  test "associated reports should be destroyed" do
    @employee.save
    @employee.reports.create!(content: "Lorem ipsum")
    assert_difference 'Report.count', -1 do
      @employee.destroy
    end
  end
  
end

# ブラウザ１でログアウト（クッキートークン・ダイジェスト・セッションの削除）
# ブラウザ２をログアウトせずに終了（セッション削除・クッキートークンは残存、ダイジェストは上記で削除済み）
# ブラウザ２でアクセス（クッキーダイジェストは削除済みだが、クッキートークンが残存）。
# headerパーシャルでヘルパーcurrent_userが呼び出された際に、クッキートークンを持っているので、
# if employee && employee.authenticated?(cookies[:remember_token])が評価される。
# この際に、クッキーダイジェストは存在しないので、クラスメソッドauthenticated?で例外が発生する。

# メールアドレスから社員番号へ変更する際は、形式チェックテストを削除する。