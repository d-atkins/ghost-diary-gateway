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
  end
end
