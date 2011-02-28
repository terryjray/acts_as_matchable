namespace :acts_as_matchable do

  desc "create rspec test table"
  task(:setup_test => :environment) do
   ActiveRecord::Base.connection.execute("create table IF NOT EXISTS matchable_tests (comments varchar(64));")
  end

  desc "remove rspec test table"
  task(:remove_test => :environment) do
    ActiveRecord::Base.connection.execute("drop table IF EXISTS matchable_tests;")
  end

end
