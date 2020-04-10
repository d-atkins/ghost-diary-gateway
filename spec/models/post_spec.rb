require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:tone) }
  end

  describe 'relationships' do
    it { should belong_to(:day) }
    it { should belong_to(:user) }
  end

  describe 'class methods' do
    it '.with_matching_group' do
      @group_1 = Group.create(name: 'Mod 1')
      @group_2 = Group.create(name: 'Mod 2')
      @user = User.create(name: 'user', uid: '1111', group: @group_1)
      @day_1 = Day.create(week: 1, day_of_week: 1, group: @group_1)
      @day_2 = Day.create(week: 2, day_of_week: 5, group: @group_2)
      @day_3 = Day.create(week: 4, day_of_week: 3, group: @group_1)
      @day_4 = Day.create(week: 6, day_of_week: 4, group: @group_1)
      @post_1 = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: @day_1, user: @user)
      @post_2 = Post.create(body: "Just took my first in class challenge. I'm NEVER going to get any better at this!!", tone: "angry", day: @day_2, user: @user)
      @post_3 = Post.create(body: "Learning that I gotta utilize my resources and getting better doesn't come out of thin air. Make sure to use paired.tech!!", tone: "optimistic", day: @day_3, user: @user)
      @post_4 = Post.create(body: "Passed Mod 1!! Time to get schwifty with the Turing crew", tone: "excited", day: @day_4, user: @user)

      expected = [@post_1, @post_3, @post_4]
      expect(Post.with_matching_group(@user.group.id).count).to eq(3)
      expect(Post.with_matching_group(@user.group.id)).to eq(expected)
    end

    it '.with_matching_group_and_user' do
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

      expected = [@post_2, @post_3]
      expect(Post.matching_group_and_user(@user_2).count).to eq(2)
      expect(Post.matching_group_and_user(@user_2)).to eq(expected)
    end
  end

end
