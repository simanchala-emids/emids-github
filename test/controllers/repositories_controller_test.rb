require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get repositories_list_url
    assert_response :success
  end

end
