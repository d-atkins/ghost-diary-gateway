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
  end

end
