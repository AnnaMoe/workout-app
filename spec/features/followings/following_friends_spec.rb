require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @john = User.create(first_name: "John",
                        last_name: "Doe",
                        email: "john@example.com",
                        password: "password")

    @peter = User.create(first_name: "Peter",
                        last_name: "Corn",
                        email: "peter@example.com",
                        password: "password")
    login_as(@john)
  end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@peter.full_name)

    # if John is signed in, we should not see the follow link next to his name
    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", :href => href)

    #should see follow link on other users name
    link = "a[href='/friendships?friend_id=#{@peter.id}']"
    find(link).click
    # after having clicked the link, the follow link should disappear
    href = "/friendships?friend_id=#{@peter.id}"
    expect(page).not_to have_link("Follow", :href => href)
  end

end