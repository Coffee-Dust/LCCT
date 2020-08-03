module CaseUtils
  class InformativeResponse
    extend CaseUtils::CaseStatistics
    def self.overview
      "There are #{new_cases} new cases today, with yesterday having #{previous_day_new_cases} new cases. There are #{Cases.last.active} active cases with a total of #{Cases.last.total} cases. #{new_deaths == 0 ? 'Thankfully' : 'Sadly'} there are #{new_deaths} new deaths today. #{calc_case_trend ? 'GOOD NEWS! The past 5 day new case trend is falling' : 'The past 5 day new case trend is rising'}. End of line user scum"
    end
  end
end
