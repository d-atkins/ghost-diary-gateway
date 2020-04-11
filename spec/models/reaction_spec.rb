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
end
