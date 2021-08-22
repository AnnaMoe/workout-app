require 'rails_helper'

RSpec.describe "user sign out" do
  before do
    @vitor = User.create(email: "vitor@web.br", password: "123456")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @vitor.email
    fill_in "Password", with: @vitor.password
    click_button "Log in"
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_link("Sign up")
    expect(page).to have_link("Sign in")
    expect(page).not_to have_link("Sign out")
  end
end