require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
  def setup
    @employee = employees(:kanri)
    @report = @employee.reports.build(content: "Lorem ipsum")
  end
  
  # 内容についてのバリデーション。タイトルを追加したときにテストを加える
  test "should be valid" do
    assert @report.valid?
  end
  test "employee id should be present" do
    @report.employee_id = nil
    assert_not @report.valid?
  end
  test "content should be present" do
    @report.content = "   "
    assert_not @report.valid?
  end
  test "content should be at most 140 characters" do
    @report.content = "a" * 501
    assert_not @report.valid?
  end
  
  # 
  test "order should be most recent first" do
    assert_equal reports(:most_recent), Report.first
  end
end
