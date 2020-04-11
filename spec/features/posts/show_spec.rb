require 'rails_helper'

RSpec.describe 'Post show -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      @group_1 = Group.create(name: 'Mod 1')
      group_2 = Group.create(name: 'Mod 2')
      user = User.create(name: 'user', uid: '1111', group: @group_1)
      day_1 = Day.create(week: 1, day_of_week: 1, group: @group_1)
      day_2 = Day.create(week: 2, day_of_week: 5, group: group_2)
      day_3 = Day.create(week: 4, day_of_week: 3, group: @group_1)
      @day_4 = Day.create(week: 6, day_of_week: 4, group: @group_1)
      Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)
      Post.create(body: "Just took my first in class challenge. I'm NEVER going to get any better at this!!", tone: "angry", day: day_2, user: user)
      Post.create(body: "Learning that I gotta utilize my resources and getting better doesn't come out of thin air. Make sure to use paired.tech!!", tone: "optimistic", day: day_3, user: user)
      @post_4 = Post.create(body: "Passed Mod 1!! Time to get schwifty with the Turing crew", tone: "excited", day: @day_4, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit post_path(@post_4)
    end

    it "sees that post's information" do
      expect(page).to have_content(@group_1.name)
      expect(page).to have_content(@day_4.week)
      expect(page).to have_content(@day_4.day_of_week)
      expect(page).to have_content(@post_4.body)
    end

    it 'sees reaction buttons' do
      within('#reactions') do
        expect(page).to have_button('Like', count: 1)
        expect(page).to have_button('Dislike', count: 1)
        expect(page).to have_button('Can relate', count: 1)
        expect(page).to have_button('Lol', count: 1)
        expect(page).to have_button('Upset', count: 1)
      end
    end
  end
end
