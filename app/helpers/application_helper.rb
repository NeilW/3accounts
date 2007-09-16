module ApplicationHelper
  
  # Show the local time
  def tz(time_at)
    TzTime.zone.utc_to_local(time_at.utc)
  end
  
  # The URL of the discussion group.
  def group_url
    "http://groups.google.com/groups/3accounts"
  end

  # The URL of the project management page
  def dev_url
    "http://dev.3accounts.co.uk"
  end
  
end
