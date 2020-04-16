require 'rails_helper'

RSpec.describe 'Posts create -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group, name: 'Mod 1')
      group_2 = create(:group, name: 'Mod 2')
      user = create(:user, group: group_1)
      @day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
      day_2 = create(:day, week: 1, day_of_week: 1, group: group_2)
      day_3 = create(:day, week: 1, day_of_week: 2, group: group_1)
      create(:post, day: @day_1, user: user)
      create(:post, day: @day_1, user: user)
      create(:post, day: @day_1, user: user)
      create(:post, day: day_2)
      create(:post, day: day_3, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(@day_1)

      visit posts_path
    end

    it 'can create a post with a generated tone, and add it to index list' do
      expect(page).to have_css(".bubble", count: 3)
      fill_in :body, with: "This is my first post. What do you think?"
      click_on('Submit')

      expect(current_path).to eq(posts_path)

      @day_1.reload
      visit posts_path
      post = Post.last
      expect(page).to have_css(".bubble", count: 4)
      expect(page).to have_content('This is my first post. What do you think?')
      expect(post.tone).to eq('Analytical')
    end

    it 'can create a post with a generated tone if text has multiple sentences, and add it to index list' do
      expect(page).to have_css(".bubble", count: 3)

      text = "He’s more myself than I am. Whatever our souls are made of,
      his and mine are the same…my great thought in living is himself."

      fill_in :body, with: text
      click_on('Submit')

      expect(current_path).to eq(posts_path)

      @day_1.reload
      visit posts_path
      post = Post.last

      expect(page).to have_css(".bubble", count: 4)
      expect(page).to have_css(".ghost-post-#{post.id}")
      expect(post.tone).to eq('Joy')
    end

    it 'can create a post with no tone' do
      expect(page).to have_css(".bubble", count: 3)
      text = 'hmm'

      fill_in :body, with: text
      click_button('Submit')

      expect(current_path).to eq(posts_path)

      @day_1.reload
      visit posts_path
      post = Post.last

      expect(page).to have_css(".bubble", count: 4)
      expect(page).to have_css(".ghost-post-#{post.id}")
      expect(post.tone).to eq('Default')
    end

    it 'can not create a post longer than 222 characters' do
      expect(page).to have_css(".bubble", count: 3)

      text = "He’s more myself than I am. Whatever our souls are made of, his and mine are the same…my great thought in living is himself. If all else perished, and he remained, I should still continue to be; and if all else remained, and he were annihilated, the universe would turn to a mighty stranger. I should not seem a part of it."

      fill_in :body, with: text
      click_on('Submit')

      expect(page).to have_css(".bubble", count: 3)
      expect(page).to have_content("Body is too long (maximum is 222 characters)")
    end

    it 'can not create an empty post' do
      expect(page).to have_css(".bubble", count: 3)

      fill_in :body, with: ''
      click_on('Submit')

      expect(page).to have_css(".bubble", count: 3)
      expect(page).to have_content("Body can't be blank")
    end

  end
end
