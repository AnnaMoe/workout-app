require 'rails_helper'

RSpec.describe "user signup" do
  scenario "with valid credentials" do
    visit "/" 
    click_link "Sign up"
    fill_in "First name", with: "Vitor"
    fill_in "Last name", with: "Reis"
    fill_in "Email", with: "vitor@web.br"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    
    visit "/"
    expect(page).to have_content("Vitor Reis")
  end

  scenario "with invalid credentials" do
    visit "/"

    click_link "Sign up"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "john@example.com"
    fill_in "Password",  with: "password"
    fill_in "Password confirmation",  with: "password"
    click_button "Sign up"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end

end