require 'test_helper'

class FaqsIndexTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @employee = employees(:kanri)
    @faqs = Faq.paginate(page: 1)
  end

  test "FAQ index" do
    log_in_as(@employee)
    get faqs_path
    assert_template 'faqs/index'
    assert_select 'div.pagination'
    @faqs.each do |faq|
      assert_match faq.question, response.body
    end
  end
end
