require 'rails_helper'

RSpec.describe CalendarService do
  it 'get_tone_by_text' do

    expect(ToneService.get_tone_by_text("I'm happy")).to eq('Joy')
    expect(ToneService.get_tone_by_text("I'm sad")).to eq('Sadness')
    expect(ToneService.get_tone_by_text("I'm scared")).to eq('Fear')
    expect(ToneService.get_tone_by_text("I'm mad")).to eq('Anger')
  end
end
