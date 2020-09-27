class CustomErrorSuper < StandardError
  attr_reader :error, :time
  def initialize(error, time)
    @error = error
    @time = time
  end
end


class ScraperNoDataError < CustomErrorSuper; end
class ScraperMissingDataError < CustomErrorSuper; end