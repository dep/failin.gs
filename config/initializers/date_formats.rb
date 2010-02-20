Date::DATE_FORMATS.merge!({
  # standard: "%B %d, %Y"
})

Time::DATE_FORMATS.merge!({
  joined_on: "%B %e, %Y",
  timestamp: "%Y/%m/%d %H:%M"
})
