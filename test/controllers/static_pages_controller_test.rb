require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "FAQ管理システム"
  end

  test "should get about_app" do
    get about_app_path
    assert_response :success
    assert_select "title", "システムについて | FAQ管理システム"
  end
  
  test "should get about_me" do
    get about_me_path
    assert_response :success
    assert_select "title", "作成者について | FAQ管理システム"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "コンタクト | FAQ管理システム"
  end

end
