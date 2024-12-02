require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  test "visiting the home page while logged out" do
    visit root_url

    assert_selector "#login", text: "Log in"
  end

  test "logging in" do
    visit new_session_url
    fill_in "Email address", with: users(:brian).email_address
    fill_in "Password", with: users(:brian).password
    click_button "Log in"

    assert_equal root_path, page.current_path
  end
end
