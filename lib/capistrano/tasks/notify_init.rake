# For Initializing GCM & APNS. 
namespace :notify_init do

# This is to Initialize GCM on Instance Setup
  desc 'Initialize GCM'
  task :gcm do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "gcm_init"
        end
      end
    end
  end

# This is to Initialize APNS on Instance Setup
  desc 'Initialize APNS'
  task :apns do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "apns_init"
        end
      end
    end
  end

end