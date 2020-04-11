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

  describe 'methods' do
    it 'reaction_by_user' do
      user1 = create(:user)
      user2 = create(:user)
      post1 = create(:post)
      post2 = create(:post)
      reaction1 = create(:reaction, category: 0, post: post1, user: user1)
      reaction2 = create(:reaction, category: 0, post: post2, user: user2)

      expect(post1.reaction_by_user(user1, 0)).to eq(reaction1)
      expect(post1.reaction_by_user(user2, 0)).to eq(nil)
      expect(post1.reaction_by_user(user1, 0)).to eq(nil)
      expect(post1.reaction_by_user(user2, 0)).to eq(reaction2)

      reaction3 = create(:reaction, category: 0, post: post1, user: user2)
      expect(post1.reaction_by_user(user2, 0)).to eq(reaction3)
    end
  end
end
