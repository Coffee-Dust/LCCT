class CheckForNewCaseDataJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    if @@status
      time = Time.parse("#{DateTime.now.tomorrow.to_date} 11am")
      self.class.set(wait_until: time).perform_later(job.arguments.first)
      puts "#{Time.now} - ACTIVEJOBS: Scheduling to check again at 11am tomorrow!"
    else
      self.class.set(wait_until: Time.now + 5.minutes).perform_later(job.arguments.first)
      puts "#{Time.now} - ACTIVEJOBS: Case data not yet updated. Trying again in 5 mins..."
    end
  end

  def perform(yar)
    # Do something later
    @@status = Cases.check_for_new_data
    puts "#{Time.now} - ACTIVEJOBS: The status for Cases.check_for_new_data called from job is: #{@@status}"
    # The case check already added a entry for the day
    if Cases.last.created_at.to_date == Time.now.to_date
      puts "#{Time.now} - ACTIVEJOBS: The last case was created today already!"
      @@status = true
    end
  end
end
