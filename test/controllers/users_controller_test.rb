require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get song" do
    get users_song_url
    assert_response :success
  end

end
