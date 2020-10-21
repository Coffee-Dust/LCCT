class Cases < ActiveRecord::Base
  validates_presence_of :total, :active, :deaths

  def self.entry_created_today?
    return Cases.last.created_at.to_date == Time.now.to_date
  end

  def self.check_for_new_data
    # scrape and instantiate new case > compare last db entry > if total is different ANDOR timestamp is next day create new entry
    # if total is the same and hours have pasted from 11am then go ahead and update
    new_case = Cases.new(CaseUtils::CaseScraper::get_new_data)

    return new_case.save if !Cases.first

    last_entry = Cases.last; 

    if last_entry.created_at.to_date <= Time.now.to_date.yesterday
      if Time.now > Time.parse("11:00 am")
        if new_case.total == last_entry.total
          # Saves new case if multiple hours have passed 
          # in case the updated total is unchanged
          return new_case.save if Time.now > Time.parse("3:00 pm")
          # Otherwise assume data has not been updated
          return false
        elsif new_case.total > last_entry.total
          new_case.save
          return true
        end
      end
    end
    #all else failed
    return false
  end

end
