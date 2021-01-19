require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  
  def setup
    @employee = employees(:kanri)
    @other = employees(:hira)
    log_in_as(@employee)
  end
  
  test "following page" do
    get following_employee_path(@employee)
    assert_not @employee.following.empty?
    assert_match @employee.following.count.to_s, response.body
    @employee.following.each do |employee|
      assert_select "a[href=?]", employee_path(employee)
    end
  end

  test "followers page" do
    get followers_employee_path(@employee)
    assert_not @employee.followers.empty?
    assert_match @employee.followers.count.to_s, response.body
    @employee.followers.each do |employee|
      assert_select "a[href=?]", employee_path(employee)
    end
  end
  
  # Ajaxを使わない方式と、使う方式の２回づつテストする。
  test "should follow a employee the standard way" do
    assert_difference '@employee.following.count', 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
  end
  test "should follow a employee with Ajax" do
    assert_difference '@employee.following.count', 1 do
      post relationships_path, xhr: true, params: { followed_id: @other.id }
    end
  end
  test "should unfollow a employee the standard way" do
    @employee.follow(@other)
    relationship = @employee.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@employee.following.count', -1 do
      delete relationship_path(relationship)
    end
  end
  test "should unfollow a employee with Ajax" do
    @employee.follow(@other)
    relationship = @employee.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@employee.following.count', -1 do
      delete relationship_path(relationship), xhr: true
    end
  end
end
