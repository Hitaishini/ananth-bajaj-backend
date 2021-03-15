# desc 'send monitoring_notification email'
# task instace_monitoring: :environment do
# 	Mail.defaults do
# 		delivery_method :smtp, 
# 		address: "smtp.gmail.com",
# 		port: 587,
# 		domain: "gmail.com",
# 		user_name: "admin@myridz.com",
# 		password: "admin@myridz",
# 		:enable_ssl => true
# 	end
# 	begin
# 		require 'net/http'
# 		uri = URI('https://silicon-honda.myridz.com/mobile/banners')
# 		res = Net::HTTP.get_response(uri).code

# 		mail = Mail.new do
# 			from     'admin@myridz.com'
# 			to       "technicalglitch@myridz.com"
# 			subject  "silicon-honda Status Code:: #{res}"

# 			html_part do
# 				content_type 'text/html; charset=UTF-8'
# 				body '<p>Click the below link to view status code information</p><br><a href="http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/">Application Status Codes</a>'
# 			end
# 		end
# 		mail.deliver!
#   	#UserMailer.monitoring_notification(res).deliver
#   rescue Exception => error
#   	mail = Mail.new do
#   		from     'admin@myridz.com'
#   		to       "technicalglitch@myridz.com"
#   		subject  "Avinashi-Ktm Status Code:: Down #{error.to_s}"

#   		html_part do
#   			content_type 'text/html; charset=UTF-8'
#   			body '<p>Click the below link to view status code information</p><br><a href="http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/">Application Status Codes</a>'
#   		end
#   	end
#   	mail.deliver!
#   end

# end
