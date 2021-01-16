require 'test_helper'

class EmployeesProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @employee = employees(:kanri)
  end

  test "profile display" do
    get employee_path(@employee)
    assert_template 'employees/show'
    assert_select 'title', full_title(@employee.name)
    assert_select 'h1', text: @employee.name
    assert_select 'h1>img.gravatar'
    assert_match @employee.reports.count.to_s, response.body
    assert_select 'div.pagination'
    @employee.reports.paginate(page: 1).each do |report|
      assert_match report.content, response.body
    end
  end
end
