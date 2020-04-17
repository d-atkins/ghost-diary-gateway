require 'rails_helper'

RSpec.describe CalendarService do
  it 'get_current_week' do

    allow_any_instance_of(Date).to receive(:strftime).and_return('2020-04-15')

    calendar_id = 'casimircreative.com_e9k9b6n7bok174ilmqbfdr0sc4@group.calendar.google.com'

    expect(CalendarService.get_current_week(calendar_id).first[:summary]).to eq('Week 5')
  end
end
