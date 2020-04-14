class CalendarService

  def self.get_current_week(calendar_id)
    response = conn.get("/calendar/v3/calendars/#{calendar_id}/events") do |f|
      f.params['key'] = ENV['GOOGLE_API_KEY']
      f.params['timeMin'] = "#{sunday}T00:00:00-07:00"
      f.params['timeMax'] = "#{saturday}T23:59:59-07:00"
      f.params['q'] = 'Week'
    end
    JSON.parse(response.body, symbolize_names: true)[:items]
  end

  private

    def self.conn
      Faraday.new("https://www.googleapis.com")
    end

    def self.sunday
      Date.today.beginning_of_week(start_day = :sunday).strftime('%Y-%m-%d')
    end

    def self.saturday
      Date.today.end_of_week(end_day = :sunday).strftime('%Y-%m-%d')
    end
end
