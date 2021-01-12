require 'test_helper'

class EmployeesSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Employee.count' do
      post employees_path, params: { employee: { name:  "",
                                         email: "employee@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'employees/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Employee.count', 1 do
      post employees_path, params: { employee: { name:  "Example Employee",
                                         email: "employee@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'employees/show'
    assert is_logged_in?
  end
  
end
