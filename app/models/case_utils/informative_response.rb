module CaseUtils
  class InformativeResponse
    extend CaseUtils::CaseStatistics
    def self.overview
      "There are #{new_cases} new cases today, with yesterday having #{previous_day_new_cases} new cases. There are #{Cases.last.active} active cases with a total of #{Cases.last.total} cases. #{new_deaths == 0 ? 'Thankfully' : 'Sadly'} there are #{new_deaths} new deaths today. #{display_case_trend} End of line user scum."
    end
    def self.new_case_overview
      "The amount of new cases for the past week: \n#{display_cases_week_format}"
    end

    private

    def self.display_case_trend
      trend = calc_case_trend
      case trend
      when 'falling'
        "GOOD NEWS! The past 3 day new case trend is falling!"
      when 'rising'
        "The past 3 day new case trend is rising."
      when 'mixed'
        "The past 3 day new case trend is mixed."
      end
    end

    def self.display_cases_week_format
      rtn_data = []
      get_prev_new_cases.each do |data|
        case_time = data[1].created_at
        rtn_data << "#{case_time.strftime('%A the '+ case_time.day.ordinalize)}: #{data[0]}"
      end
      return rtn_data.join("\n")
    end
  end
end
