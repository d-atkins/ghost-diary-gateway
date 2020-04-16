require 'rails_helper'

RSpec.describe "Profile -", type: :feature do
  before (:each) do
    @group_1 = Group.create(name: 'Mod 1')
  end

  describe 'Registered user' do
    before(:each) do
      @user = User.create(name: 'user', uid: '1111', group: @group_1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile'
    end

    it "I am able to see stats and posts links" do
      expect(page).to have_link('My Stats')
      expect(page).to have_link('My Posts')
    end

    it "I can click the stats link and be taken to the stats page" do
      click_link('My Stats')

      expect(current_path).to eq('/profile/stats')
      expect(page).to have_content('My Stats')
    end

    it "I can click the posts link and be taken to the posts page" do
      click_link('My Posts')

      expect(current_path).to eq('/profile/posts')
      expect(page).to have_content('My Posts')
    end
  end

  describe 'Visitor' do
    it "I get a 404 error" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist (404")
    end
  end
end
