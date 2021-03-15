class Website::TestmonialsController < ApplicationController
  before_action :set_testmonial, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user!

  # GET /web/v1/testmonials
  # GET /web/v1/testmonials.json
  def get_all_testmonial
    @testmonials = Testmonial.order("created_at desc")

    render json: @testmonials
  end

   def get_limit_testmonials
    @testmonials = Testmonial.order("created_at desc").limit(5) #where(visible: true)
    
    render json: @testmonials
  end

  def positive_testmonial
     testmonials = Testmonial.where(visible: true)
     @some = []
     testmonials.each do |test|
      testmonial =  $analyzer.sentiment test.description
        @some << test if testmonial != :negative
      end
     render json: @some
  end

  def dealer_testmoail_images
    @dealer_iamge = TestmonialDealerImage.where(category: params[:category])

    render json: @dealer_iamge
  end

  # GET /web/v1/testmonials/1
  # GET /web/v1/testmonials/1.json
  def show
    render json: @testmonial
  end

  # POST /web/v1/testmonials
  # POST /web/v1/testmonials.json
  def create
    @testmonial = Testmonial.new(testmonial_params)

    if @testmonial.save
      UserMailer.delay.nofity_testmonial_to_dealer(@testmonial)
      render json: @testmonial, status: :created
    else
      render json: @testmonial.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/testmonials/1
  # PATCH/PUT /web/v1/testmonials/1.json
  def update
    @testmonial = Testmonial.find(params[:id])

    if @testmonial.update(testmonial_params)
      head :no_content
    else
      render json: @testmonial.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/testmonials/1
  # DELETE /web/v1/testmonials/1.json
  def destroy
    @testmonial.destroy

    head :no_content
  end

  private

    def set_testmonial
      @testmonial = Testmonial.find(params[:id])
    end

    def testmonial_params
      params.require(:testmonial).permit(:name, :description, :user_id, :visible, :email, :image, :mobile)
    end
end
