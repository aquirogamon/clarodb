  Date::DATE_FORMATS[:month_day_year_hora] = "%B %e, %Y at %I:%M %p"
  Date::DATE_FORMATS[:short_ordinal] = lambda { |date| date.strftime("%B #{date.day.ordinalize}") }