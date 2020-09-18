require 'open-uri'
module CaseUtils
  class CaseScraper

    def self.get_new_data
      data = scrape

      raise ScraperMissingDataError if missing_data?(data)

      return data
    end

    private
    def self.scrape
      #: total, active, deaths F
      doc = Nokogiri::HTML(open("https://covid.knoxcountytn.gov/includes/covid_cases.csv"))
      data_hash = {}
      content = doc.css("p").text

      raise ScraperNoDataError if content == "" || nil

      data_hash[:total] = content.match(/Number of Confirmed Cases,([0-9]+)/i)[1].to_i
      data_hash[:active] = content.match(/Number of Active Cases,([0-9]+)/i)[1].to_i
      data_hash[:deaths] = content.match(/Deaths,([0-9]+)/i)[1].to_i
      
      return data_hash
    end

    def self.missing_data?(hash)
      #convert the value to nil if its == 0 and collect the value
      hash.collect { |key, value| value = nil if value == 0; value }.include?(nil)
    end

  end
end