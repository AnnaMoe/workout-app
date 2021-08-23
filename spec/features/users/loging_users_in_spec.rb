require 'rails_helper'

RSpec.describe "Logging users in" do
  before do
    @vitor = User.create(email: "vitor@web.br", password: "123456")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    # strings of "Email" and "password" are the labels in the form
    fill_in "Email", with: "vitor@web.br"
    fill_in "Password", with: "123456"
    click_button "Log in"

    # expect(page).to have_content("Signed in sucessfully.")
    expect(page).to have_content("Signed in as #{@vitor.email}")
    expect(page).to have_link("Sign out")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end
end