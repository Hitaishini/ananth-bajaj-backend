desc "Initialize APNS Configs"
task :apns_init => :environment do
	app = Rpush::Apns::App.new
	app.name = "Silicon-Honda"
	app.certificate = File.read("lib/siliconhonda.pem")
	app.environment = "production" # APNs environment.
	app.password = "certificate password"
	app.connections = 1
	app.save!
end