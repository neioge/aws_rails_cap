require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @report = reports(:orange)
  end
  
  # FAQでも応用できるテスト
  test "should redirect create when not logged in" do
    assert_no_difference 'Report.count' do
      post reports_path, params: { report: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  # FAQでも応用できるテスト
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Report.count' do
      delete report_path(@report)
    end
    assert_redirected_to login_url
  end
end
