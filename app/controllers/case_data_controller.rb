class CaseDataController < ApplicationController

  def overview
    #Check if there are any active errors

    if e = CaseUtils::ErrorReporter.active_errors?(clear: true)

      render plain: "Internal Server Error 569: #{e.name}"

    else

      if Cases.entry_created_today?
        render plain: CaseUtils::InformativeResponse.overview
      else
        render plain: "The data has not been updated for today. \n#{CaseUtils::InformativeResponse.overview}"
      end

    end#endif error check
  end

  def week_overview
    render plain: CaseUtils::InformativeResponse.new_case_overview
  end

  def force_check
    CheckForNewCaseDataJob.perform_later(nil)
    redirect_to action: "overview"
  end

end
