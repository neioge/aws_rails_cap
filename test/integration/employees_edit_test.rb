require 'test_helper'

class EmployeesEditTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:kanri)
  end
  
  # 今後必要になるテスト。管理者のフィクスチャーでログインして、他の従業員を変更するテスト（フィクスチャーが複数必要）
    
  test "unsuccessful edit" do
    log_in_as(@employee)
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    patch employee_path(@employee), params: { employee: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'employees/edit'
  end
  # fixtureでログイン
  # ログイン中の従業員のエディット画面にゲット送信
  # ビューがエディットになっているか確認
  # 無効な編集内容をパッチ送信
  # エディットビューが再び表示されるか
  # こちらは、チュートリアルから変更しても変える必要はない。
  
  test "successful edit with friendly forwarding" do
    get edit_employee_path(@employee)
    log_in_as(@employee)
    assert_redirected_to edit_employee_url(@employee)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch employee_path(@employee), params: { employee: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @employee
    @employee.reload
    assert_equal name,  @employee.name
    assert_equal email, @employee.email
  end
  # フィクスチャーの編集画面をゲット送信する
  # リダイレクトされたルート画面からログインする
  # フレンドリーフォワーディングにより、編集画面が表示されているかをテストする
  # フラッシュが表示されていないことを確認。
  # ショービューが表示され、名前とメールアドレスが変更後の内容になっているかを確認。
  # チュートリアルから変更する必要なし。ただ注意というか、覚えておくべきなのは、従業員詳細を見るときにもフレフォしたいので、
  # そのテストが必要になると思う。
  
end
