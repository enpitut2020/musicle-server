require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get song" do
    get user_song_url
    assert_response :success
  end

end
