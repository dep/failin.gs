Date::DATE_FORMATS.merge!({
  # standard: "%B %d, %Y"
})

Time::DATE_FORMATS.merge!({
  joined_on: "%B %e, %Y",
  timestamp: "%m/%d/%Y, %I:%M%P"
})
