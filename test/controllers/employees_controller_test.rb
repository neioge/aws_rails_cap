# 基本的には、ログインしていない状態でアクセスした際に、リダイレクトされるかどうかを

require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @employee = employees(:kanri)
    @other_employee = employees(:hira)
  end
  
  # newアクションもログインしないと使えないようにする予定
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get edit_employee_path(@employee)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
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
    assert_redirected_to root_url
  end

  # 管理者による従業員の編集ができるようにした際は、このテストを消す必要がある。代わりに、管理者権限有・無で削除させるテストを書く
  test "should redirect update when logged in as wrong employee" do
    log_in_as(@other_employee)
    patch employee_path(@employee), params: { employee: { name: @employee.name,
                                              email: @employee.email } }
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
  
  test "should redirect following when not logged in" do
    get following_employee_path(@employee)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_employee_path(@employee)
    assert_redirected_to login_url
  end

end
