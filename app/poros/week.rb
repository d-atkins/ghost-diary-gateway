class Week
  def self.determine(event_data)
    get_valid_week(split_events(event_data)).last.to_i
  end

  private

    def self.split_events(event_data)
      event_data.map{ |event| event[:summary].split }
    end

    def self.get_valid_week(summary_arrays)
      summary_arrays.find { |split_event| valid_week(split_event) }
    end

    def self.valid_week(split_event)
      split_event.length == 2 && split_event.first.downcase == 'week'
    end
end
