require 'rails_helper'

RSpec.describe 'Post show -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group)
      user = create(:user, group: group_1)
      poster = create(:user, group: group_1)
      day_1 = create(:day, group: group_1)
      day_2 = create(:day, group: group_1)
      day_3 = create(:day, group: group_1)
      3.times {
        create(:post, day: day_1, user: poster)
        create(:post, day: day_2, user: poster)
        create(:post, day: day_3, user: poster)
      }
      @post = create(:post, day: day_1, user: poster)
      create(:reaction, category: 0, post: @post)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit post_path(@post)
      click_button('Like')
      click_button('Lol')
      click_button('Can relate')
    end

    it 'can undo their reactions' do
      click_button('Undo like')

      expect(current_path).to eq(post_path(@post))
      expect(page).to have_button('Like', count: 1)
      expect(page).to_not have_button('Undo like', count: 1)

      click_button('Undo can relate')

      expect(current_path).to eq(post_path(@post))
      expect(page).to have_button('Like', count: 1)
      expect(page).to_not have_button('Undo like', count: 1)
      expect(page).to have_button('Can relate', count: 1)
      expect(page).to_not have_button('Undo can relate', count: 1)

      click_button('Undo lol')

      expect(current_path).to eq(post_path(@post))
      expect(page).to have_button('Like', count: 1)
      expect(page).to_not have_button('Undo like', count: 1)
      expect(page).to have_button('Can relate', count: 1)
      expect(page).to_not have_button('Undo can relate', count: 1)
      expect(page).to have_button('Lol', count: 1)
      expect(page).to_not have_button('Undo lol', count: 1)
    end

    it 'can negate a like with a dislike' do
      click_button('Dislike')

      expect(current_path).to eq(post_path(@post))
      expect(page).to have_button('Like', count: 1)
      expect(page).to_not have_button('Undo like', count: 1)
      expect(page).to_not have_button('Dislike', count: 1)
      expect(page).to have_button('Undo dislike', count: 1)
    end

    it 'can negate an lol with an upset' do
      click_button('Upset')

      expect(current_path).to eq(post_path(@post))
      expect(page).to have_button('Lol', count: 1)
      expect(page).to_not have_button('Undo lol', count: 1)
      expect(page).to_not have_button('Upset', count: 1)
      expect(page).to have_button('Undo upset', count: 1)
    end
  end
end
