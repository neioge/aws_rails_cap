require 'test_helper'

class EmployeesIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = employees(:kanri)
    @non_admin = employees(:hira)
  end

  # 無限スクロールを入れない限りは必要。入れたら必要。編集機能をつけたら、編集リンクがあるかもテストするべき。
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get employees_path
    assert_template 'employees/index'
    assert_select 'div.pagination'
    first_page_of_employees = Employee.paginate(page: 1)
    first_page_of_employees.each do |employee|
      assert_select 'a[href=?]', employee_path(employee), text: employee.name
      unless employee == @admin
        assert_select 'a[href=?]', employee_path(employee), text: '削除'
      end
    end
    assert_difference 'Employee.count', -1 do
      delete employee_path(@non_admin)
    end
  end
  
end
