class VehicleFaq < ActiveRecord::Base

	belongs_to :bike


def self.import(file)
  begin     
     CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      faqs = self.find_by_id(row["id"]) || new      
      faqs.bike_id = Bike.find_by_name(row[0].strip).try(:id)
      faqs.bike_type = row[1]
      faqs.cate_gory_type = row[2]
      faqs.value = row[3]
      faqs.save! 
    end
  rescue StandardError => e 
    raise "Error on row #{$.}====#{e.message}==="    
  end
end

private

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Bike Name","Bike Type", "Type", "Specification", "Value"]
    end
  end
end


