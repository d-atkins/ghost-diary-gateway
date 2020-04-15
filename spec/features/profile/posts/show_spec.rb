require 'rails_helper'

RSpec.describe "Profile/posts show page -", type: :feature do
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
      2.times { create(:reaction, category: 1, post: @post_2) }
      7.times { create(:reaction, category: 2, post: @post_2) }
      create(:reaction, category: 3, post: @post_2)
      11.times { create(:reaction, category: 4, post: @post_2) }

      visit profile_post_path(@post_2)
    end

    it "sees the post's information" do
      expect(page).to have_content(@post_2.id)
      expect(page).to have_content('Mod 1')
      expect(page).to have_content('Week 1')
      expect(page).to have_content('Monday')
      expect(page).to have_content(@post_2.created_at.strftime("Posted on %m/%d/%Y at %I:%M%p"))
      expect(page).to have_content(@post_2.body)
    end

    it "sees the post's reaction information" do
      within('#reactions') do
        expect(page).to have_content('Liked by no one')
        expect(page).to have_content('Disliked by two')
        expect(page).to have_content('Seven can relate')
        expect(page).to have_content('Made one laugh')
        expect(page).to have_content("Made 11 say 'ugh'")
      end
    end
  end
end
