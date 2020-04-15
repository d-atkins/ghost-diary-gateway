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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)

      visit post_path(@post)
    end

    it 'can react positively to a post' do
      find('#reaction-0').click

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_css('#reaction-0', count: 1)
      expect(page).to have_css('#negate-reaction-0', count: 1)

      find('#reaction-2').click

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_css('#reaction-0', count: 1)
      expect(page).to have_css('#negate-reaction-0', count: 1)
      expect(page).to_not have_css('#reaction-2', count: 1)
      expect(page).to have_css('#negate-reaction-2', count: 1)

      find('#reaction-3').click

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_css('#reaction-0', count: 1)
      expect(page).to have_css('#negate-reaction-0', count: 1)
      expect(page).to_not have_css('#reaction-2', count: 1)
      expect(page).to have_css('#negate-reaction-2', count: 1)
      expect(page).to_not have_css('#reaction-3', count: 1)
      expect(page).to have_css('#negate-reaction-3', count: 1)
    end

    it 'can react negatively to a post' do
      find('#reaction-1').click

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_css('#reaction-1', count: 1)
      expect(page).to have_css('#negate-reaction-1', count: 1)

      find('#reaction-4').click

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_css('#reaction-1', count: 1)
      expect(page).to have_css('#negate-reaction-1', count: 1)
      expect(page).to_not have_css('#reaction-4', count: 1)
      expect(page).to have_css('#negate-reaction-4', count: 1)
    end
  end
end
