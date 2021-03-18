class Accessory < ApplicationRecord
	audited
	has_many :wishlists, :through => :accessory_wishlist
	#has_many :tags, through: :accessory_tags
	#has_many :accessory_tags, dependent: :destroy
	#mount_base64_uploader :image, ImageUploader, file_name: 'accessory'
	belongs_to :bike


	def self.import(file)
		begin     
			CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
				bike_aceesory = find_by_id(row["id"]) || new
				bike_aceesory.attributes = row.to_hash
				bike_aceesory.save!
			end
		rescue StandardError => e 
			raise "Error on row #{$.}====#{e.message}==="    
		end
		
	end



	def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["title","description", "tag", "image","accessory_category_id","part_number","size","price","brand","bike_id"]
    end
  end

	def accessory_cate_name
		self.tags.try(:first).try(:accessory_category).try(:title) || "N/A"
	end

	def add_tags(params)
		params.each do |tag|
			AccessoryTag.create(accessory_id: self.id, tag_id: tag)
		end
	end	

	def tag_name 
		self.tags.pluck(:name)
	end	

	def tag_ids 
		self.tags.pluck(:id)
	end	

	def bike_acce_name
		self.bike.try(:name) if self.bike
	end

	def active
		user = User.current_user
		logger.info "====================================#{user.inspect}===kumarbell=="
        if user.try(:wishlist).try(:accessories)
			user.wishlist.accessories.pluck(:id).include?(self.id) ? "true" : "false"
		else
			"false"
		end
	end

	def service_created_at
		self.created_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end	

	def acc_updated_at
		self.updated_at.in_time_zone('Chennai').strftime('%d-%m-%y %H:%M')
	end

	def as_json(options={})
		super.as_json(options).merge({updated_at: acc_updated_at, bike_name: bike_acce_name, :created_at => service_created_at,  active: active })
	end
end
