class CustomExceptions < StandardError
  attr_reader :error, :time
  def initialize(error, time)
    @error = error
    @time = time
  end
end


class ScraperNoDataError < CustomExceptions; end
class ScraperMissingDataError < CustomExceptions; end