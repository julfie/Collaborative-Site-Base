namespace :db do
    desc "Erase and fill database"
    # creating a rake task within db namespace called 'populate'
    # executing 'rake db:populate' will cause this script to run
    task :populate => :environment do
      require 'factory_girl_rails'
      require 'populator'
      include Populator
      
      # Step 0: drop old databases and rebuild
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:test:prepare'].invoke
  
      # Step 1: create roles
      create_roles
      
      # Step 2: create projects
      create_projects
  
      # Step 3: create project roles 
      create_project_roles
  
    end
  end