require 'test_helper'

class FaqTest < ActiveSupport::TestCase
  def setup
    @employee = employees(:kanri)
    @faq = @employee.faqs.build(question: "窓口の名前を教えてください。",
                                answer: "片野銀行IBサポートデスクです。",)
  end
  
  # 基本的な入力値のバリデーション
    test "should be valid" do
      assert @faq.valid?
    end
    test "employee id should be present" do
      @faq.employee_id = nil
      assert_not @faq.valid?
    end
    test "question should be present" do
      @faq.question = "   "
      assert_not @faq.valid?
    end
    test "question should be at most 140 characters" do
      @faq.question = "a" * 501
      assert_not @faq.valid?
    end
    test "answer should be present" do
      @faq.answer = "   "
      assert_not @faq.valid?
    end
    test "answer should be at most 140 characters" do
      @faq.answer = "a" * 501
      assert_not @faq.valid?
    end
  # 基本的な入力値のバリデーション
  
  # FAQはできればアクセス、参照された回数で並び替えたいけど、かなり
  test "order should be most recent first" do
    assert_equal faqs(:most_recent), Faq.first
  end
end
