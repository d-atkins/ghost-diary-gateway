require 'rails_helper'

RSpec.describe "Profile/posts index -", type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group, name: 'Mod 1')
      group_2 = create(:group, name: 'Mod 2')
      user = create(:user, group: group_1)
      day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
      day_2 = create(:day, week: 1, day_of_week: 1, group: group_2)
      day_3 = create(:day, week: 1, day_of_week: 2, group: group_1)
      @post_1 = create(:post, day: day_1, user: user)
      @post_2 = create(:post, day: day_1, user: user)
      @post_3 = create(:post, day: day_1, user: user)
      @post_4 = create(:post, day: day_2)
      @post_5 = create(:post, day: day_3, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)

      visit '/profile/posts'
    end

    it 'sees a list of all posts they made' do
      expect(page).to have_content("Your Posts")
      expect(page).to_not have_link("Click to see post #{@post_4.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_1.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_2.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_3.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_5.id}'s info.")
      expect(page).to have_content(@post_1.body)
    end

    it "can click a link to see a post's show page" do
      click_link("Click to see post #{@post_2.id}'s info.")

      expect(current_path).to eq(profile_post_path(@post_2))
    end
  end
end
