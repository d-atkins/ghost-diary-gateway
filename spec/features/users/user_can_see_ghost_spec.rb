require 'rails_helper'

RSpec.describe "As a Registered User" do
  before(:each) do
    group_1 = create(:group, name: 'Mod 1')
    user = create(:user, group: group_1)
    day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
    @post = create(:post, day: day_1, user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)
  end

  it "I can see a ghost on the homepage" do
    visit "/"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on the posts index page" do
    visit "/posts"

    within ".post-#{@post.id}" do
      expect(page).to have_css(".ghost-container")
    end
  end

  it "I can see a ghost on the posts show page" do
    visit "/posts/#{@post.id}"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on my posts show page" do
    visit "/profile/posts/#{@post.id}"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on my posts index page" do
    visit "/profile/posts"

    within ".post-#{@post.id}" do
      expect(page).to have_css(".ghost-container")
    end
  end
end
