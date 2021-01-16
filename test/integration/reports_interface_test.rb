require 'test_helper'

class ReportsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:kanri)
  end

  test "report interface" do
    log_in_as(@employee)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Report.count' do
      post reports_path, params: { report: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
    # 有効な送信
    content = "有効な日報を送信する"
    assert_difference 'Report.count', 1 do
      post reports_path, params: { report: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    # 以下の文章が理解できない。
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_report = @employee.reports.paginate(page: 1).first
    assert_difference 'Report.count', -1 do
      delete report_path(first_report)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    # 編集後、消す予定。
    get employee_path(employees(:hira))
    assert_select 'a', text: 'delete', count: 0
  end
end
