require_relative './environment'

StandaloneMigrations::Tasks.load_tasks

desc "API Routes"
task :routes do
  Futurama::Quotes.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path
    puts "     #{method} #{path}"
  end
end
