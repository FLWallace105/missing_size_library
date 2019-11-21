#Rakefile
require 'dotenv'
Dotenv.load
require 'active_record'
#require 'resque'
#require 'resque/tasks'
require 'sinatra/activerecord/rake'
require_relative 'update_orders'


namespace :order_update do
desc 'fix orders'
task :fix_order do |t|
    
    UpdatePrepaidOrders::ChangeOrders.new.update_orders
end

desc 'fix subs'
task :fix_sub do |t|
    UpdatePrepaidOrders::ChangeOrders.new.test_subs_properties

end



end