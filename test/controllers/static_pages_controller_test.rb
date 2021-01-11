require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "ホーム | FAQ管理システム"
  end

  test "should get about_me" do
    get static_pages_about_me_url
    assert_response :success
    assert_select "title", "作成者について | FAQ管理システム"
  end
  
  test "should get about_app" do
    get static_pages_about_app_url
    assert_response :success
    assert_select "title", "システムについて | FAQ管理システム"
  end

end
