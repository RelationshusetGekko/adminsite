require 'erb'

namespace :adminsite do

  desc "Create default admin"
  task :create_admin do
    run_with_rake 'adminsite:create_admin'
  end

  namespace :seed do

    namespace :assets do

      desc "Clear out all assets"
      task :clear do
        run_with_rake 'adminsite:seed:assets:clear'
      end

      desc "Overwrite assets in seed data"
      task :dump do
        run_with_rake 'adminsite:seed:assets:dump'
      end

      desc "Load assets from seed data"
      task :import do
        run_with_rake 'adminsite:seed:assets:load'
      end

      desc "Clear assets and load them from seeds again"
      task :reload do
        run_with_rake 'adminsite:seed:assets:reload'
      end

    end

    namespace :page_layouts do

      desc "Clear out all page layouts"
      task :clear do
        run_with_rake 'adminsite:seed:page_layouts:clear'
      end

      desc "Overwrite page layouts in seed data"
      task :dump do
        run_with_rake 'adminsite:seed:page_layouts:dump'
      end

      desc "Load page layouts from seed data"
      task :import do
        run_with_rake 'adminsite:seed:page_layouts:load'
      end

      desc "Clear page layouts and load them from seeds again"
      task :reload do
        run_with_rake 'adminsite:seed:page_layouts:reload'
      end
    end

    namespace :pages do

      desc "Clear out all pages"
      task :clear do
        run_with_rake 'adminsite:seed:pages:clear'
      end

      desc "Overwrite pages in seed data"
      task :dump do
        run_with_rake 'adminsite:seed:pages:dump'
      end

      desc "Load pages from seed data"
      task :import do
        run_with_rake 'adminsite:seed:pages:load'
      end

      desc "Clear pages and load them from seeds again"
      task :reload do
        run_with_rake 'adminsite:seed:pages:reload'
      end
    end
  end
end
