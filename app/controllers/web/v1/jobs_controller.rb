class Web::V1::JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user!

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

  # POST /web/v1/jobs
  # POST /web/v1/jobs.json
  def create
    @job = Job.new(job_params)

    if @job.save
      render json: @job, status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/jobs/1
  # PATCH/PUT /web/v1/jobs/1.json
  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      head :no_content
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/jobs/1
  # DELETE /web/v1/jobs/1.json
  def destroy
    @job.destroy

    head :no_content
  end

  def delete_jobs
    @jobs = params[:job_ids]
    @jobs.each do |acc|
      Job.find(acc).destroy
    end
    head :no_content 
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :location, :technologies_required, :experience_required, :interview, :required_skills, :note, :notice_period)
  end
end

