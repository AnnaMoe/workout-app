require 'rails_helper'

RSpec.describe 'deleting exercise' do
  before do
    @owner = User.create!(email: "john@example.com",
      password: "password")
    @owner_exer = @owner.exercises.create!(duration_in_min: 48,
                                workout: "My body building activity",
                                workout_date: Date.today
                              )
    login_as(@owner)
  end

  scenario do
    visit "/"

    click_link "My Lounge"

    click_link "Destroy"
    expect(page).to have_content("Exercise has been deleted")
    expect(page).to have_content("New Workout")
  end

end