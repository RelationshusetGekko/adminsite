require 'erb'
namespace :app do
  desc "Create default admin"
  task :setup_admin_site do
    run_with_rake 'adminsite:setup'
  end
  
  def run_with_rake(task_name)
    rake = fetch(:rake, 'rake')
    run "cd #{current_path} && " +
        "RAILS_ENV=production #{rake} -f #{current_path}/Rakefile #{task_name}"
  end
end