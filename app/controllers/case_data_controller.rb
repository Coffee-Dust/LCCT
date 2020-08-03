class CaseDataController < ApplicationController

  def overview
    begin
      if Cases.entry_created_today?
        render plain: CaseUtils::InformativeResponse.overview
      else
        render plain: "The data has not been updated for today. \n#{CaseUtils::InformativeResponse.overview}"
      end
    rescue => error
      render plain: "Server Error 569: #{error}"
    end

  end

end
