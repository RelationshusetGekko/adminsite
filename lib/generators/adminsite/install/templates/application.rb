require 'erb'

namespace :app do

  namespace :adminsite do

    desc "Create default admin"
    task :create_admin do
      run_with_rake 'adminsite:create_admin'
    end
  end

  def run_with_rake(task_name)
    rake = fetch(:rake, 'rake')
    run "cd #{current_path} && " +
        "RAILS_ENV=production #{rake} -f #{current_path}/Rakefile #{task_name}"
  end
end