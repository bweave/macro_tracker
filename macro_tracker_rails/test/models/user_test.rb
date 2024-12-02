require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "#name" do
    assert_equal "Brian Weaver", users(:brian).name
  end
end
