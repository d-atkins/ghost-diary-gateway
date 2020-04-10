require 'rails_helper'

RSpec.describe "As a Registered User on the profile page", type: :feature do
  before(:each) do
    group_1 = Group.create(name: 'Mod 1')
    @user = User.create(name: 'user', uid: '1111', group: group_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/profile'
  end

  it "I am able to see stats and posts links" do
    expect(page).to have_link('My Stats')
    expect(page).to have_link('My Posts')
    expect(page).to have_content("#{@user.name} is logged in.")
  end

  it "I can click the stats link and be taken to the stats page" do
    click_link('My Stats')
    expect(current_path).to eq('/profile/stats')
    expect(page).to have_content('Your Statistics')
  end

  it "I can click the posts link and be taken to the posts page" do
    click_link('My Posts')
    expect(current_path).to eq('/profile/posts')
    expect(page).to have_content('Your Posts')
  end

  it "with no user, I get an error message asking me to login" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
    visit '/profile'
    expect(page).to have_content("You must login to view your profile's information.")
    expect(current_path).to eq('/')
  end


end
