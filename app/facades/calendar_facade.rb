class CalendarFacade
  attr_reader :calendar_week

  def week_of(calendar_id)
    event_data = CalendarService.get_current_week(calendar_id)
    Week.determine(event_data)
  end
end
