require 'rails_helper'

RSpec.describe "creating homepage" do
  scenario "see content and links on the homepage" do
    visit "/"
    expect(page).to have_content("Workout Lounge!")
    expect(page).to have_content("Show off your workout")
    expect(page).to have_link("Home")
    expect(page).to have_link("Athletes Den")
  end

end