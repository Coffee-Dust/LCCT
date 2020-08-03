module CaseUtils
  module CaseStatistics
    def new_cases
      return calc_case_diff(Cases.last.id, Cases.last.id-1)
    end

    def previous_day_new_cases
      return calc_case_diff(Cases.last.id-1, Cases.last.id-2)
    end

    def new_deaths
      begin
        current = Cases.last
        last_entry = Cases.find(current.id-1)
        return current.deaths - last_entry.deaths
      rescue
        return "<data unavailable>"
      end
    end

    def calc_case_trend
      #Gather new cases from the prevous days - If at least 4 or so in a row are more or less than the previous
      #return that status
    end

    def calc_case_diff(case1ID, case2ID)
      begin
        return Cases.find(case1ID).total - Cases.find(case2ID).total
      rescue
        return "<data unavailable>"
      end
    end
  end
end