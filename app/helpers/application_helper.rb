module ApplicationHelper
  def format_time(time_str)
    hours, minutes = time_str.split(':')
    "#{hours.to_i} hours #{minutes.to_i} minutes"
  end
end
  