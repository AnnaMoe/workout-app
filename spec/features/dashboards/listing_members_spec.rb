require 'rails_helper'

RSpec.describe 'listing members' do
  before do
    @vitor = User.create(email: "vitor@web.br", first_name: "Vitor", last_name: "Reis", password: "123456")
    @sarah = User.create(email: "sarah@web.br", first_name: "Sarah", last_name: "Doe", password: "123456")
  end

  scenario "shows a list of registered members" do
    visit "/"
    expect(page).to have_content("List of Members")
    expect(page).to have_content(@vitor.full_name)
    expect(page).to have_content(@sarah.full_name)
  end

end