require 'dotenv'
Dotenv.load
require 'httparty'
require 'resque'
require 'active_record'
require "sinatra/activerecord"

require_relative 'models/model'
#require_relative 'resque_helper'
require_relative 'lib/order_size'

module UpdatePrepaidOrders
    class ChangeOrders

        def initialize
            Dotenv.load
            @apikey = ENV['ELLIE_API_KEY']
            @shopname = ENV['SHOPNAME']
            @password = ENV['ELLIE_PASSWORD']
            @recharge_access_token = ENV['RECHARGE_ACCESS_TOKEN']
            @my_header = {
                "X-Recharge-Access-Token" => @recharge_access_token
            }
            @my_change_charge_header = {
                "X-Recharge-Access-Token" => @recharge_access_token,
                "Accept" => "application/json",
                "Content-Type" =>"application/json"
            }

          end


          def update_orders

            #ANY Prepaid
            my_end_month = Date.today.end_of_month
            my_end_month_str = my_end_month.strftime("%Y-%m-%d")
            puts "End of the month = #{my_end_month_str}"

            my_start_month_plus = Date.today 
            my_start_month_plus = my_start_month_plus >> 1
            my_start_month_plus = my_start_month_plus.end_of_month + 1
            my_start_month_plus_str = my_start_month_plus.strftime("%Y-%m-%d")
            puts "my start_month_plus_str = #{my_start_month_plus_str}"


            update_prepaid_sql = "insert into update_prepaid (order_id, transaction_id, charge_status, payment_processor, address_is_active, status, order_type, charge_id, address_id, shopify_id, shopify_order_id, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address, synced_at) select order_id, transaction_id, charge_status, payment_processor, address_is_active, status, order_type, charge_id, address_id, shopify_id, shopify_order_id, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address, synced_at from orders where is_prepaid = '1'  and scheduled_at > \'#{my_end_month_str}\' and scheduled_at < \'#{my_start_month_plus_str}\' and status = \'QUEUED\' "
            ActiveRecord::Base.connection.execute(update_prepaid_sql)

            #temp_prepaid = UpdatePrepaidOrder.all
            #temp_prepaid.each do |myt|
            #    puts myt.order_id
            #    puts myt.line_items.first['properties'].inspect
            #    myprops = myt.line_items.first['properties']
            #    myprops.each do |myp|
            #        puts myp.inspect
            #        sports_bra = myp.select{|x| x['name'] == 'sports-bra'}
            #        if sports_bra == []
            #            puts "Exiting order id #{myt.order_id}"
            #            exit
            #        end
            #    end
            #end

            my_order = UpdatePrepaidOrder.find_by_order_id(127127560)
            temp_json = my_order.line_items.first
            
           # temp_json['properties']
            
            puts "temp_json = #{temp_json.inspect}"
            puts "-------"
            puts temp_json['properties'].inspect
            my_index = 0
            temp_json['properties'].map do |tj|
                if tj['name'] == 'sports-bra'
                    temp_json['properties'].delete_at(my_index)
                end
                my_index += 1
            end

            puts "----"
            puts temp_json['properties'].inspect
            puts "now fixing ..."

            my_json = OrderSize.add_missing_size(temp_json)
            puts "FIXED from lib my_json = #{my_json.inspect}"


          end


          def test_subs_properties
            my_sub = Subscription.find_by_subscription_id(51613432)
            puts "Displaying info sub #{my_sub.subscription_id}"
            puts my_sub.raw_line_item_properties.inspect
            temp_json = my_sub.raw_line_item_properties
            my_index = 0
            temp_json.map do |tj|
                if tj['name'] == 'sports-bra'
                    temp_json.delete_at(my_index)
                end
                my_index += 1
            end
            puts "----"
            puts "temp_json = #{temp_json.inspect}"
            puts "Fixing with add_missing_sub_size"
            new_json = OrderSize.add_missing_sub_size(temp_json)
            puts "new_json = #{new_json.inspect}"


          end
          

    end
end