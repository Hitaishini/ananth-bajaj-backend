require 'csv'

namespace :routes do
  desc 'Print out defined routes into csv, with TARGET and PATTERN'
  task :csv do |task|
    routes_task = Rake::Task['routes'].invoke.first
    routes = routes_task.call

    target = ENV['TARGET'] || 'tmp/routes.csv'
    CSV.open(target, 'wb') do |csv|
      csv << ['name', 'verb', 'path']
      routes.each do |route|
        next if ENV['PATTERN'] && !route[:path].include?(ENV['PATTERN'])
        csv << [route[:name], route[:verb], route[:path]]
      end
    end
  end
end