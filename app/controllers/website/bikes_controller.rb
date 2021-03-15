class Website::BikesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :set_bike, only: [:show]

  # GET /mobile/v1/bikes
  # GET /mobile/v1/bikes.json
  def index
    @bikes = Bike.where('non_bajaj = ? and visible = ?', false, true).order("display_order")  #.includes(:specifications)
    render json: @bikes, each_serializer: Website::V1::BikeSerializer  
  end

  #for min and max values
  def min_max_values
    @bike = Bike.min_max
    render json: @bike
  end

  #for bikea with bike type
  def bikes_with_type
    @bike = BikeType.joins(:bikes).where(available: true, bikes: {non_bajaj: false}).order("display_order").uniq.collect { |f| {"#{f.name}": f.bikes}}

    render json: @bike, root: false
  end

  # GET /mobile/v1/bikes/1
  # GET /mobile/v1/bikes/1.json
  def show
    render json: @bike
  end

  #compare vehicles display
  def compare_data
    bikes = []
    bike = Bike.find(params[:id])
    bikes << params[:id]
    bikes << bike.compare_vehicles if bike
    bike_compare = Bike.find(bikes.uniq.compact).sort 

    render json: bike_compare, each_serializer: Website::V1::BikeSerializer
  end

  def email_price
    user = User.find_by_id(params[:user_id])
    @price_data = EmailPriceList.create(name: params[:name], email: params[:email], mobile: params[:mobile], varient_id: params[:id] , user_id:params[:user_id])  
    UserMailer.delay.send_price_document(params)
    UserMailer.delay.send_price_document_dealer(user, params, @price_data)
    render json: {message: "Document Sent!"} 
  end

  def email_emi_data
    user = User.find_by_id(params[:user_id])
    UserMailer.delay.send_emi_price(params, user)
    
    render json: {message: "Email Sent!"} 
  end

  #for bike compare changes
  def bike_compare
    bike = Bike.compare(params)

    render json: bike
  end

  #pdef genartae changes
  def price_chart_pdf
    @price_data = EmailPriceList.create(name: params[:name], email: params[:email], mobile: params[:mobile], category: "Price Chart")
    UserMailer.delay.dealer_pdf_email(params, @price_data) 
    bikes_data = []
    
    Bike.where(visible: true).order(:display_order).each do |bike|
      var = []
      price_fields = PriceField.where(active: true).order(:display_order) 
       bike.varients.where(visible: true).each do |f|
        price = {}
        price_fields.each do |p|
          if p.name == "Ex Showroom Price"
              p.name = "Ex_Showroom_Price"
          elsif p.name == "LTT Charges & RTO"
            p.name = "Registration_Charges"
          elsif p.name == "Insurance"
            p.name = "Insurance"
          elsif p.name == "On Road Price"
            p.name = "On_Road_Price"
          end
        price[p.name] = f.pricings.find_by_price_field_id(p.id).try(:value)
        price["Variant_Name"] = f.pricings.find_by_price_field_id(1).try(:varient).try(:varient_name)
        # binding.pry
         # var << { "Ex_Showroom_Price": f.pricings.find_by_price_field_id(1).try(:value), "LTT_Charges_And_RTO": f.pricings.find_by_price_field_id(2).try(:value), "Insurance": f.pricings.find_by_price_field_id(3).try(:value),"Variant_Name": f.pricings.find_by_price_field_id(1).try(:varient).try(:varient_name), "On_Road_Price": f.pricings.find_by_price_field_id(4).try(:value) }
        end         
        var << price
      end
      bikes_data << { model_name: bike.name, "Non_Bajaj": bike.non_bajaj,"DisplayOrder": bike.display_order, varient_data: bike.varients.where(visible: true), price_data: var}
    end

    render json: bikes_data
  end

  def download_pdf_price_chart
    @bikes = Bike.all
    
    render :pdf => "Pdf Report",:template => "uploads/generate_pdf.html.erb", :orientation => 'Landscape' ,:title => 'Pdf Report'
    UserMailer.delay.genartae_pdf_customer_email(params) 
    
  end

  def pdf_for_email
     @bikes = Bike.where(non_bajaj: false, visible: true)

     # pdf = WickedPdf.new.pdf_from_html_file('/uploads/generate_pdf.html.erb')
     # send_data(pdf, 
     #     :filename    => "temp.pdf", 
     #     :disposition => 'attachment') 

      render :pdf => "Report.pdf", disposition: 'inline', :template => "uploads/generate_pdf.html.erb", :filename => "temp.pdf"
  end

  def pdf_url
    @bikes = Bike.where(non_bajaj: false, visible: true)

    pdf = WickedPdf.new.pdf_from_string(
        render_to_string(pdf: 'pricelisty', template: 'uploads/generate_pdf.html.erb')
        )
       send_data(pdf, 
         :filename    => "pricelist.pdf", 
         :disposition => 'attachment') 
  end


 def bike_filter
   @bikes = Bike.filter(params)
    #@bike = bikes.uniq
    render json: @bikes
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

end
