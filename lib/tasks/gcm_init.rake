desc "Initialize GCM Configs"
task :gcm_init => :environment do
	app = Rpush::Gcm::App.new
	app.name = "Silicon-Honda"
	app.auth_key = "AIzaSyBcYwNMtTa0XHTAqgAEWMs7BPEbUVDSYag"
	app.connections = 1
	app.save!
end