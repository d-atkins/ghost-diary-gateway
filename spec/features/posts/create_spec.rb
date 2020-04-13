require 'rails_helper'

RSpec.describe 'Posts create -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      @group_1 = Group.create(name: 'Mod 1')
      @group_2 = Group.create(name: 'Mod 2')
      @user = User.create(name: 'user', uid: '1111', group: @group_1)
      @day_1 = Day.create(week: 1, day_of_week: 1, group: @group_1)
      @day_2 = Day.create(week: 2, day_of_week: 5, group: @group_2)
      @day_3 = Day.create(week: 4, day_of_week: 3, group: @group_1)
      @day_4 = Day.create(week: 6, day_of_week: 4, group: @group_1)
      @post_1 = Post.create(body: 'Wow, first day of the mod 1... syllabus day... but still so lost @.@', tone: 'confuse', day: @day_1, user: @user)
      @post_2 = Post.create(body: "Just took my first in class challenge. I'm NEVER going to get any better at this!!", tone: 'angry', day: @day_2, user: @user)
      @post_3 = Post.create(body: "Learning that I gotta utilize my resources and getting better doesn't come out of thin air. Make sure to use paired.tech!!", tone: 'optimistic', day: @day_3, user: @user)
      @post_4 = Post.create(body: 'Passed Mod 1!! Time to get schwifty with the Turing crew', tone: 'excited', day: @day_4, user: @user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit posts_path
    end

    it 'can create a post with a generated tone, and add it to index list' do
      expect(page).to have_link("Click", count: 3)
      expect(page).to have_field(:body, with: "")

      fill_in :body, with: "This is my first post. What do you think?"

      expect(find_field(:body).value).to eq("This is my first post. What do you think?")

      click_on('Submit')

      expect(current_path).to eq(posts_path)

      post = Post.last

      expect(page).to have_link("Click", count: 4)
      expect(page).to have_link("Click to see post #{post.id}'s info.")
      expect(page).to have_content(post.body)
      expect(post.tone).to eq('Analytical')
    end

    it 'can create a post with a generated tone if text has multiple sentences, and add it to index list' do
      expect(page).to have_link("Click", count: 3)
      expect(page).to have_field(:body, with: "")

      text = "He’s more myself than I am. Whatever our souls are made of,
      his and mine are the same…my great thought in living is himself."

      fill_in :body, with: text

      expect(find_field(:body).value).to eq(text)

      click_on('Submit')

      expect(current_path).to eq(posts_path)

      post = Post.last

      expect(page).to have_link("Click", count: 4)
      expect(page).to have_link("Click to see post #{post.id}'s info.")
      expect(post.tone).to eq('Joy')
    end

    it 'can create a post with no tone' do
      expect(page).to have_link("Click", count: 3)
      text = 'hmm'

      fill_in :body, with: text
      click_button('Submit')

      expect(current_path).to eq(posts_path)

      post = Post.last

      expect(page).to have_link("Click", count: 4)
      expect(page).to have_link("Click to see post #{post.id}'s info.")
      expect(post.tone).to eq('Default')
    end

    it 'does not create post with more than 222 characters' do
      expect(page).to have_link("Click", count: 3)

      text = "He’s more myself than I am. Whatever our souls are made of, his and mine are the same…my great thought in living is himself. If all else perished, and he remained, I should still continue to be; and if all else remained, and he were annihilated, the universe would turn to a mighty stranger. I should not seem a part of it."

      fill_in :body, with: text
      click_on('Submit')

      expect(page).to have_link("Click", count: 3)
      expect(page).to have_content("Your post cannot exceed 222 characters. Your post was #{text.length} characters.")
    end

    it 'does not create post with empty string' do
      expect(page).to have_link("Click", count: 3)

      fill_in :body, with: ""
      click_on('Submit')

      expect(page).to have_link("Click", count: 3)
      expect(page).to have_content("Your post cannot be empty.")
    end

  end
end
