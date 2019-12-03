require 'test_helper'

class JsakesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get jsakes_new_url
    assert_response :success
  end

end
