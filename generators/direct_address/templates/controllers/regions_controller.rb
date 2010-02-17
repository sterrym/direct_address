class RegionsController < ApplicationController
  
	def index
    @regions = params[:country_id] && Region.by_country(params[:country_id])
    respond_to do |format|
			format.json
    end
  end

end
