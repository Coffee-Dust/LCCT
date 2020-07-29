module CaseScraper

  def get_new_data
    data = scrape

    raise ScraperMissingDataError if missing_data?(data)

    return data
  end

  private
  def scrape
    #: total, active, deaths F
    doc = Nokogiri::HTML(open("https://covid.knoxcountytn.gov/includes/covid_cases.csv"))
    data_hash = {}
    content = doc.css("p").text

    raise ScraperNoDataError if content == "" || nil

    data_hash[:total] = content.match(/Number of Cases\*,([0-9]+)/i)[1].to_i
    data_hash[:active] = content.match(/Active Cases,([0-9]+)/i)[1].to_i
    data_hash[:deaths] = content.match(/Deaths,([0-9]+)/i)[1].to_i

    return data_hash
  end

  def missing_data?(hash)
    #convert the value to nil if its == 0 and collect the value
    hash.collect { |key, value| value = nil if value == 0; value }.include?(nil)
  end

end