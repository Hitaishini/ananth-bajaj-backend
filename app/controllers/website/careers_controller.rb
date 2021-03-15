class Website::CareersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_career, only: [:show, :update, :destroy]

  # GET /web/v1/careers
  # GET /web/v1/careers.json
  def index
    @careers = Career.all

    render json: @careers
  end

  # GET /web/v1/careers/1
  # GET /web/v1/careers/1.json
  def show
    render json: @career
  end

  # POST /web/v1/careers
  # POST /web/v1/careers.json
  def create
    @career = Career.new(career_params)

    if @career.save
       render json: @career, status: :created
       UserMailer.delay.dealer_mail_for_career(@career)
       UserMailer.delay.user_mail_for_career(@career)
    #  rescue StandardError => e
    #   CustomLogger.file_log(e)
    # end
   
  else
    render json: @career.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /web/v1/careers/1
  # PATCH/PUT /web/v1/careers/1.json
  def update
    @career = Career.find(params[:id])

    if @career.update(career_params)
      head :no_content
    else
      render json: @career.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/careers/1
  # DELETE /web/v1/careers/1.json
  def destroy
    @career.destroy

    head :no_content
  end

  private

  def set_career
    @career = Career.find(params[:id])
  end

  def career_params
   params.require(:career).permit(:name, :email, :mobile, :experience_years, :experience_months, :current_company, :cover_letter, :cv_file)
 end
end
