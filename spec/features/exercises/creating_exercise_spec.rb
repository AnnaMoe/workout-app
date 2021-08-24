require 'rails_helper'

RSpec.describe 'creating exercise' do
  before do
    @vitor = User.create(email: "vitor@web.br", password: "123456")
    # devise method used for testing
    # Warden in rails helper
    login_as(@vitor)
    visit "/"

    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")
  end

  scenario "with valid inputs" do

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight Lifting"
    fill_in "Activity date", with: "2016-07-26"
    click_button "Create Workout"

    expect(page).to have_content("Exercise has been created")
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@vitor, exercise))
    # belongs_to association
    expect(exercise.user_id).to eq(@vitor.id)
  end

  scenario "with invalid inputs" do
    

    fill_in "Duration", with: ""
    fill_in "Workout Details", with: ""
    fill_in "Activity date", with: ""
    click_button "Create Workout"

    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")    
    expect(page).to have_content("Workout date can't be blank")
    # expect(page).to have_content("Activity date can't be blank")
  end
end