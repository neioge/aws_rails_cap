require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  # こちらは機能拡張時に最初に変更する必要があるテスト
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", about_app_path
    assert_select "a[href=?]", about_me_path
    assert_select "a[href=?]", contact_path
  end
end
