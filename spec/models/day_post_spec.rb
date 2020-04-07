require 'rails_helper'

RSpec.describe DayPost, type: :model do
  xdescribe 'relationships' do
    it { should belong_to(:day) }
    it { should belong_to(:post) }
  end
end
