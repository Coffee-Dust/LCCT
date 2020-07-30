class CheckForNewCaseDataJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    if @@status
      time = Time.parse("#{DateTime.now.tomorrow.to_date} 11am")
      self.class.set(wait_until: time).perform_later(job.arguments.first)
    else
      self.class.set(wait_until: 5.minutes).perform_later(job.arguments.first)
    end
  end

  def perform(yar)
    # Do something later
    @@status = Cases.check_for_new_data
    puts @@status
  end
end
