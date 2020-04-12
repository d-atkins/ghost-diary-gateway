require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:tone) }
  end

  describe 'relationships' do
    it { should belong_to(:day) }
    it { should belong_to(:user) }
    it { should have_many(:reactions) }
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
      expect(post2.reaction_by_user(user1, 0)).to eq(nil)
      expect(post2.reaction_by_user(user2, 0)).to eq(reaction2)

      reaction3 = create(:reaction, category: 0, post: post1, user: user2)
      expect(post1.reaction_by_user(user2, 0)).to eq(reaction3)
    end

    it 'add_reaction' do
      user1 = create(:user)
      post = create(:post)
      3.times { create(:reaction, category:0, post:post) }
      create(:reaction, category: 0, post: post, user: user1)
      3.times { create(:reaction, category:0, post:post) }

      expect(post.reactions.find_by(user: user1, category: 0)).to_not be_nil
      expect(post.reactions.where(category: 0).length).to eq(7)

      post.add_reaction(user1, 1)

      expect(post.reactions.find_by(user: user1, category: 0)).to be_nil
      expect(post.reactions.where(category: 0).length).to eq(6)
    end
  end
end
