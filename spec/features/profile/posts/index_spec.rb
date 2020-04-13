require 'rails_helper'

RSpec.describe "Profile/posts index -", type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      @group_1 = Group.create(name: 'Mod 1')
      @group_2 = Group.create(name: 'Mod 2')
      @user = User.create(name: 'user', uid: '1111', group: @group_1)
      @user_2 = User.create(name: 'user_2', uid: '1112', group: @group_1)
      @day_1 = Day.create(week: 1, day_of_week: 1, group: @group_1)
      @day_2 = Day.create(week: 2, day_of_week: 5, group: @group_1)
      @day_3 = Day.create(week: 4, day_of_week: 3, group: @group_1)
      @day_4 = Day.create(week: 6, day_of_week: 4, group: @group_2)
      @post_1 = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: @day_1, user: @user)
      @post_2 = Post.create(body: "Just took my first in class challenge. I'm NEVER going to get any better at this!!", tone: "angry", day: @day_2, user: @user_2)
      @post_3 = Post.create(body: "Learning that I gotta utilize my resources and getting better doesn't come out of thin air. Make sure to use paired.tech!!", tone: "optimistic", day: @day_3, user: @user_2)
      @post_4 = Post.create(body: "Passed Mod 1!! Time to get schwifty with the Turing crew", tone: "excited", day: @day_4, user: @user_2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit '/profile/posts'
    end

    it 'sees a list of all posts they made' do
      expect(page).to have_content("Your Posts")
      expect(page).to_not have_link("Click to see post #{@post_1.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_4.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_2.id}'s info.")
      expect(page).to have_link("Click to see post #{@post_3.id}'s info.")
      expect(page).to have_content(@post_2.body)
      expect(page).to have_content(@post_3.body)
    end

    it "can click a link to see a post's show page" do
      click_link("Click to see post #{@post_2.id}'s info.")

      expect(current_path).to eq(profile_post_path(@post_2))
    end
  end
end
