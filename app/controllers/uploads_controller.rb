require "csv"

class UploadsController < ActionController::Base

  layout 'application'

  def import
    begin
      raise "Please select File" unless params[:file]
      Bike.import(params[:file])
      flash[:success] = "Bikes Uploaded Successfully"
      redirect_to :back
    rescue StandardError => e
      flash[:error] = "Uploading Failed with error::#{e.message}"
      redirect_to :back    
    end 

  end

  def import_specifications
   begin
    raise "Please select File" unless params[:file]
    Specification.import(params[:file])
    flash[:success] = "Specifications Uploaded Successfully"
    redirect_to :back
  rescue StandardError => e
    flash[:error] = "Uploading Failed with error::#{e.message}"
    redirect_to :back    
  end 
  
end

def import_users
   begin
    raise "Please select File" unless params[:file]
    User.import(params[:file])
    flash[:success] = "Users Uploaded Successfully"
    redirect_to :back
  rescue StandardError => e
    flash[:error] = "Uploading Failed with error::#{e.message}"
    redirect_to :back    
  end 
end

#upload users with bikes
def import_user_bikes
   begin
    raise "Please select File" unless params[:file]
    User.import_user_bikes(params[:file])
    flash[:success] = "Users With Bikes Uploaded Successfully"
    redirect_to :back
  rescue StandardError => e
    flash[:error] = "Uploading Failed with error::#{e.message}"
    redirect_to :back    
  end 
end

def import_service_history
 begin
  raise "Please select File" unless params[:file]
  ServiceHistory.import(params[:file])
  flash[:success] = "Service History Uploaded Successfully"
  redirect_to :back
rescue StandardError => e
  flash[:error] = "Uploading Failed with error::#{e.message}"
  redirect_to :back    
end 

end

def import_prices
 begin
  raise "Please select File" unless params[:file]
  Pricing.import(params[:file])
  flash[:success] = "Prices Uploaded Successfully"
  redirect_to :back
rescue StandardError => e
  flash[:error] = "Uploading Failed with error::#{e.message}"
  redirect_to :back    
end 

end

def import_key_features
 begin
  raise "Please select File" unless params[:file]
  KeyFeature.import(params[:file])
  flash[:success] = "Key Features Uploaded Successfully"
  redirect_to :back
rescue StandardError => e
  flash[:error] = "Uploading Failed with error::#{e.message}"
  redirect_to :back    
end 

end

def import_colors
 begin
  raise "Please select File" unless params[:file]
  BikeColor.import(params[:file])
  flash[:success] = "Bike Colors Uploaded Successfully"
  redirect_to :back
rescue StandardError => e
  flash[:error] = "Uploading Failed with error::#{e.message}"
  redirect_to :back    
end 

end

def import_service_schedules
 begin
  raise "Please select File" unless params[:file]
  ServiceSchedule.import(params[:file])
  flash[:success] = "Service Schedules Uploaded Successfully"
  redirect_to :back
rescue StandardError => e
  flash[:error] = "Uploading Failed with error::#{e.message}"
  redirect_to :back    
end 

end

def import_accessories
  begin
    raise "Please select File" unless params[:file]
    Accessory.import(params[:file])
    flash[:success] = "Accessories Uploaded Successfully"
    redirect_to :back
  rescue StandardError => e
    flash[:error] = "Uploading Failed with error::#{e.message}"
    redirect_to :back    
  end 
end
def download_price_value_date
    #@products = PriceValue.all
    respond_to do |format|
      format.html
      format.csv { send_data Pricing.generate_csv(params[:bike_name], params[:varient]) }
      format.xls
    end
end 


def import_faqs
  begin
    raise "Please select File" unless params[:file]
      VehicleFaq.import(params[:file]) 
      flash[:success] = "VehicleFaqs Uploaded Successfully"
      redirect_to :back   
  rescue Exception => e
    flash[:error] = "Uploading Failed with error::#{e.message}"
    redirect_to :back
  end
end

  def import_varients
    begin
      raise "Please select File" unless params[:file]
    Varient.import(params[:file])
    flash[:success] = "Varients Uploaded Successfully"
    redirect_to :back
    rescue StandardError => e
      flash[:error] = "Failed with error::#{e.message}"
      redirect_to :back    
    end 
  end  


  def import_used_bikes
    begin
      raise "Please select File" unless params[:file]
      usedbike = UsedBike.import(params[:file])
      flash[:success] = "Used Bikes Uploaded Successfully"
      redirect_to :back
    rescue StandardError => e
      flash[:error] = "Uploading Failed with error::#{e.message}"
      redirect_to :back    
    end 

  end

  def down_load_used_bikes
     @usedbikes = UsedBike.all
    respond_to do |format|
      format.html
      format.csv { send_data UsedBike.generate_used_bike(@usedbikes) }
      format.xls
    end
  end

  def upload_used_bikes


  end

def upload_faqs


end

def upload_bikes
end

def upload_specifications   
end

def upload_users   
end

def upload_service_history   
end

def upload_prices   
end

def upload_key_features   
end

def upload_colors   
end

def upload_service_schedules   
end

def upload_accessories   
end

 def upload_varients
 end 

 #for my bikes with user
 def upload_user_bikes
 end





def download_users
  @products = User.all
  respond_to do |format|
    format.csv { send_data User.to_csv }
  end
end

def down_user_bikes
  #@products = User.all
  respond_to do |format|
    format.csv { send_data User.user_bike_csv_download }
  end
end

def download_faqs
@faqs = VehicleFaq.all
 respond_to do |format|
    format.csv { send_data VehicleFaq.to_csv }
 end
end

def download_bikes
  @products = User.all
  respond_to do |format|
    format.csv { send_data Bike.attribute_names.to_csv }
  end
end 

def download_specifications
  respond_to do |format|
    format.csv { send_data Specification.to_csv }
  end
end

def download_key_features
  respond_to do |format|
    format.csv { send_data KeyFeature.to_csv }
  end
end

def down_load_accessories
   respond_to do |format|
    format.csv { send_data Accessory.to_csv }
  end
end

def down_load_bike_colors
  respond_to do |format|
    format.csv { send_data BikeColor.to_csv }
  end
end

def down_load_service_history
  respond_to do |format|
    format.csv { send_data ServiceHistory.to_csv }
  end
end

def down_load_service_schedule
  respond_to do |format|
    format.csv { send_data ServiceSchedule.to_csv }
  end
end

def down_load_prices
  respond_to do |format|
    format.csv { send_data Pricing.to_csv }
  end
end

def down_load_varients
  respond_to do |format|
    format.csv { send_data Varient.to_csv }
  end
end


end
