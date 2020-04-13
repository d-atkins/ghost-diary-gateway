require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:tone) }
    it { should validate_length_of(:body) }
  end

  describe 'relationships' do
    it { should belong_to(:day) }
    it { should belong_to(:user) }
    it { should have_many(:reactions) }
  end

  describe 'methods' do
    it 'reactions_by_user' do
      user1 = create(:user)
      post1 = create(:post)
      reaction1 = create(:reaction, category: 0, post: post1, user: user1)
      reaction2 = create(:reaction, category: 2, post: post1, user: user1)
      reaction3 = create(:reaction, category: 3, post: post1, user: user1)

      expect(post1.reactions_by_user(user1)).to eq([reaction1, nil, reaction2, reaction3, nil])
    end

    describe 'add_reaction' do
      before(:each) do
        @user1 = create(:user)
        @post = create(:post)
        3.times { create(:reaction, category:0, post: @post) }
        create(:reaction, category: 0, post: @post, user: @user1)
        3.times { create(:reaction, category:0, post: @post) }
      end

      it 'deletes an opposite reaction from the same user' do
        expect(@post.reactions.find_by(user: @user1, category: 0)).to_not be_nil
        expect(@post.reactions.where(category: 0).length).to eq(7)

        @post.add_reaction(@user1, 1)

        expect(@post.reactions.find_by(user: @user1, category: 0)).to be_nil
        expect(@post.reactions.where(category: 0).length).to eq(6)
      end

      it "can't add multiple likes from the same user" do
        expect(@post.reactions.where(category: 0, user: @user1).length).to eq(1)

        @post.add_reaction(@user1, 0)
        
        expect(@post.reactions.where(category: 0, user: @user1).length).to eq(1)
      end
    end
  end
end
