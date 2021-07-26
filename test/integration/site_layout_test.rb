require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template "home/home"
    assert_select "a[href=?]", root_path, count=1
    assert true
  end
end
