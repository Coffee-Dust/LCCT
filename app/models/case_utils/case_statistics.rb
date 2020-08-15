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
      #allow a difference in them - i.e 5 cases
      #return that status ##
      case_diff = get_prev_new_cases
      collection = []
      case_diff.each.with_index do |data, i|
        if case_diff[i+1] != nil
          if (data[0] - case_diff[i+1][0]) > 5
            collection << true 
          else
            collection << false
          end
        end
      end

      case
      when collection.all?{|e| e==true }
        return "falling"
      when collection.all?{|e| e==false}
        return "rising"
      else
        return "mixed"
      end
    end

    def calc_case_diff(case1ID, case2ID)
      begin
        return Cases.find(case1ID).total - Cases.find(case2ID).total
      rescue
        return "<data unavailable>"
      end
    end

    def get_prev_new_cases
      cases = Cases.order(created_at: :desc).limit(4).reverse
      amount_data = []
      cases.each.with_index do |kase, i|
        if i > 0
          diff = kase.total - cases[i-1].total
          amount_data << [diff, kase]
        end
      end
      return amount_data
    end

  end
end