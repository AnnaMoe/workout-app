require 'rails_helper'

RSpec.describe 'editing exercise' do
  before do
    @owner = User.create!(email: "john@example.com",
      password: "password", first_name: "Vitor", last_name: "Reis")
    @owner_exer = @owner.exercises.create!(duration_in_min: 48,
                                workout: "My body building activity",
                                workout_date: Date.today
                              )
    login_as(@owner)
  end

  scenario 'with valid input' do
    visit "/"

    click_link "My Lounge"

    link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exer.id}/edit']"
    find(link).click

    fill_in "Duration", with: 45
    click_button "Update Exercise"
    expect(page).to have_content("Exercise has been updated")
    expect(page).not_to have_content("48")
    expect(page).to have_content("45")
  end
end