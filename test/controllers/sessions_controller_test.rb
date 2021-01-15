require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  # 多分消す必要はない
  test "should get new" do
    get login_path
    assert_response :success
  end

end
