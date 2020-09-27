module CaseUtils
  class ErrorReporter
    require_relative "../../errors/custom_errors.rb"
    @@active = []

    def self.active
      @@active
    end

    def self.report(error)
      @@active << error
      puts "Reporting Error: #{error.name}"
      return @@active
    end

    def self.active_errors?(clear: false)
      storage = @@active.clone
      if storage.empty?
        return false
      else
        @@active.clear if clear
        return storage[0]
      end
    end

  end
end