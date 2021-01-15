require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @employee = employees(:kanri)
    @other_employee = employees(:hira)
  end
  
  # のちに、従業員作成画面もログインしないとできないようにするので、エディットアクションのテストと似たようになると思う。
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  # createアクションのテストがないのは、POST送信が不可能だからかな。
  
  # エディット画面が正しく表示されるかのテストは統合テストでやっているので、こちらではアクセスが禁止されていることを確認する
  test "should redirect edit when not logged in" do
    get edit_employee_path(@employee)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  # 同様にPATCH送信が禁止されているかどうかを確認する。残す。
  test "should redirect update when not logged in" do
    patch employee_path(@employee), params: { employee: { name: @employee.name,
                                              email: @employee.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  # 管理者による従業員の編集ができるようにした際は、このテストを消す必要がある。代わりに、管理者権限有・無で削除させるテストを書く。
  test "should redirect edit when logged in as wrong employee" do
    log_in_as(@other_employee)
    get edit_employee_path(@employee)
    assert flash.empty?
    assert_redirected_to root_url
  end

  # 管理者による従業員の編集ができるようにした際は、このテストを消す必要がある。代わりに、管理者権限有・無で削除させるテストを書く
  test "should redirect update when logged in as wrong employee" do
    log_in_as(@other_employee)
    patch employee_path(@employee), params: { employee: { name: @employee.name,
                                              email: @employee.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect index when not logged in" do
    get employees_path
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Employee.count' do
      delete employee_path(@employee)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_employee)
    assert_no_difference 'Employee.count' do
      delete employee_path(@employee)
    end
    assert_redirected_to root_url
  end

end
