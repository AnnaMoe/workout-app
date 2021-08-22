require 'rails_helper'

RSpec.describe "user signup" do
  scenario "with valid credentials" do
    visit "/" 
    click_link "Sign up"
    fill_in "Email", with: "vitor@web.br"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario 'with invalid credentials' do
    visit "/" 
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
  end

end