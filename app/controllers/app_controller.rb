class AppController < ApplicationController
  def index
    studies = Study.all
    respond_to do |format|
      format.json { render json: studies }
    end
  end
  
  def result
    respond_to do |format|
      format.json {
        result_json = JSON.parse(params[:result])

        selections = result_json.delete("selections")
               
        result = Result.new(result_json)
        result.save!
        selections.each do |study_image_id|
          result.selections.create(:study_image_id => study_image_id)
        end
        result.save!
        render json: 'OK'
      }
    end
  end
end