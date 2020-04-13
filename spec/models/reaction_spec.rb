require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:category) }
    it { should define_enum_for(:category).with_values([:like, :dislike, :can_relate, :lol, :upset]) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    it 'opposite' do
      post = create(:post)
      like = create(:reaction, post: post, category: 0)
      dislike = create(:reaction, post: post, category: 1)
      can_relate = create(:reaction, post: post, category: 2)
      lol = create(:reaction, post: post, category: 3)
      upset = create(:reaction, post: post, category: 4)

      expect(like.opposite).to eq('dislike')
      expect(dislike.opposite).to eq('like')
      expect(can_relate.opposite).to be_nil
      expect(lol.opposite).to eq('upset')
      expect(upset.opposite).to eq('lol')
    end

    it 'amount_of' do
      post = create(:post)
      create_list(:reaction, 3, category: 0, post: post)
      create_list(:reaction, 102, category: 1, post: post)
      create_list(:reaction, 12, category: 2, post: post)
      create_list(:reaction, 0, category: 3, post: post)
      create_list(:reaction, 56, category: 4, post: post)
      create(:reaction, category: 0)

      expect(post.reactions.amount_of(0)).to eq(3)

      expect(Reaction.amount_of(0)).to eq(4)
      expect(Reaction.amount_of(1)).to eq(102)
      expect(Reaction.amount_of(2)).to eq(12)
      expect(Reaction.amount_of(3)).to eq(0)
      expect(Reaction.amount_of(4)).to eq(56)
    end
  end
end
