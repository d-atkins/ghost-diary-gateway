class Week
  def self.determine(event_data)
    found_event = get_valid_week(split_events(event_data))
    get_week_number(found_event)
  end

  private

    def self.split_events(event_data)
      event_data.map{ |event| event[:summary].split }
    end

    def self.get_valid_week(summary_arrays)
      summary_arrays.find { |split_event| valid_week(split_event) }
    end

    def self.valid_week(split_event)
      first = split_event.first.downcase
      split_event.length == 2 && (first == 'week' || first == 'intermission')
    end

    def self.get_week_number(event)
      return -1 if event.nil?
      event.last.to_i
    end
end
