class Website::JobsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_job, only: [:show]

  # GET /web/v1/jobs
  # GET /web/v1/jobs.json
  def index
    @jobs = Job.all

    render json: @jobs
  end

  # GET /web/v1/jobs/1
  # GET /web/v1/jobs/1.json
  def show
    render json: @job
  end

  private

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :location, :technologies_required, :experience_required, :interview, :required_skills, :note, :notice_period)
    end
end
