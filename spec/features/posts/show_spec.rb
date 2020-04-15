require 'rails_helper'

RSpec.describe 'Post show -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group, name: 'Mod 1')
      group_2 = create(:group, name: 'Mod 2')
      user = create(:user, group: group_1)
      day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
      day_2 = create(:day, week: 1, day_of_week: 1, group: group_2)
      day_3 = create(:day, week: 1, day_of_week: 2, group: group_1)
      @post = create(:post, day: day_1, user: user)
      create(:post, day: day_1, user: user)
      create(:post, day: day_1, user: user)
      create(:post, day: day_2)
      create(:post, day: day_3, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)

      visit post_path(@post)
    end

    it "sees that post's information" do
      expect(page).to have_content('Mod 1')
      expect(page).to have_content('Week 1')
      expect(page).to have_content('Monday')
      expect(page).to have_content(@post.body)
    end

    it 'sees reaction buttons' do
      within('#reactions') do
        expect(page).to have_css('#reaction-0', count: 1)
        expect(page).to have_css('#reaction-1', count: 1)
        expect(page).to have_css('#reaction-2', count: 1)
        expect(page).to have_css('#reaction-3', count: 1)
        expect(page).to have_css('#reaction-4', count: 1)
      end
    end
  end
end
