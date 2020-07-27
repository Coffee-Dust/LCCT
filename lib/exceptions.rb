class ScraperNoDataError < StandardError
  def message
    "Tried to scrape usings a pattern that returned NULL: Recheck website struct"
  end
end

class ScraperMissingDataError < StandardError; end