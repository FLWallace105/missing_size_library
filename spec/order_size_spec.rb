#order_size_spec.rb
require "order_size"
#require_relative "../models/model"
require_relative "../update_orders"
describe OrderSize do
    describe ".add_missing_size" do
        context "given missing sports-bra" do
            it "gets sports-bra size from tops and fills in" do
                #grab an order, get the line item properties
                my_order = UpdatePrepaidOrder.find_by_order_id(127127560)
                temp_json = my_order.line_items.first
                #remove the sports-bra property
                my_index = 0
                temp_json['properties'].map do |tj|
                if tj['name'] == 'sports-bra'
                    temp_json['properties'].delete_at(my_index)
                end
                my_index += 1
                end
                #Fix the json and add back the sports-bra size from tops
                my_json = OrderSize.add_missing_size(temp_json)
                sports_bra = my_json['properties'].select{|x| x['name'] == 'sports-bra'}
                #puts sports_bra.inspect
                expect(sports_bra.first['value']).to eql("L")
                
            end   
        end

        context "given missing sports-jacket" do
            it "gets sports-jacket size from tops and fills in" do
                #grab an order, get the line item properties
                my_order = UpdatePrepaidOrder.find_by_order_id(127127560)
                temp_json = my_order.line_items.first
                #remove the sports-jacket property
                my_index = 0
                temp_json['properties'].map do |tj|
                if tj['name'] == 'sports-jacket'
                    temp_json['properties'].delete_at(my_index)
                end
                my_index += 1
                end
                #Fix the json and add back the sports-jacket size from tops
                my_json = OrderSize.add_missing_size(temp_json)
                sports_jacket = my_json['properties'].select{|x| x['name'] == 'sports-jacket'}
                expect(sports_jacket.first['value']).to eql("L")
                
            end   
        end

        context "given missing tops" do
            it "gets sports-bra size from tops and fills in" do
                #grab an order, get the line item properties
                my_order = UpdatePrepaidOrder.find_by_order_id(127127560)
                temp_json = my_order.line_items.first
                #remove the tops property
                my_index = 0
                temp_json['properties'].map do |tj|
                if tj['name'] == 'tops'
                    temp_json['properties'].delete_at(my_index)
                end
                my_index += 1
                end
                #Fix the json and add back the tops size from sports-bra
                my_json = OrderSize.add_missing_size(temp_json)
                tops = my_json['properties'].select{|x| x['name'] == 'tops'}
                expect(tops.first['value']).to eql("L")
                
            end   
        end


    end

    describe ".add_missing_sub_size" do
        context "given missing sports-bra" do
            it "gets sports-bra size from tops and fills in" do
                #grab an sub, get the raw_line_item_properties
                my_sub = Subscription.find_by_subscription_id(51613432)
                #remove the sports-bra property
                temp_json = my_sub.raw_line_item_properties
                my_index = 0
                temp_json.map do |tj|
                    if tj['name'] == 'sports-bra'
                        temp_json.delete_at(my_index)
                    end
                    my_index += 1
                end
                #Fix the json and add back the sports-bra size from tops
                my_json = OrderSize.add_missing_sub_size(temp_json)
                sports_bra = my_json.select{|x| x['name'] == 'sports-bra'}
                #puts sports_bra.inspect
                expect(sports_bra.first['value']).to eql("L")
                
            end   
        end

        context "given missing sports-jacket" do
            it "gets sports-jacket size from tops and fills in" do
                #grab an sub, get the raw_line_item_properties
                my_sub = Subscription.find_by_subscription_id(51613432)
                #remove the sports-bra property
                temp_json = my_sub.raw_line_item_properties
                my_index = 0
                temp_json.map do |tj|
                    if tj['name'] == 'sports-jacket'
                        temp_json.delete_at(my_index)
                    end
                    my_index += 1
                end
                #Fix the json and add back the sports-bra size from tops
                my_json = OrderSize.add_missing_sub_size(temp_json)
                sports_jacket = my_json.select{|x| x['name'] == 'sports-jacket'}
                #puts sports_bra.inspect
                expect(sports_jacket.first['value']).to eql("L")
                
            end   
        end

        context "given missing tops" do
            it "gets tops size from sports-bra and fills in" do
                #grab an sub, get the raw_line_item_properties
                my_sub = Subscription.find_by_subscription_id(51613432)
                #remove the sports-bra property
                temp_json = my_sub.raw_line_item_properties
                my_index = 0
                temp_json.map do |tj|
                    if tj['name'] == 'tops'
                        temp_json.delete_at(my_index)
                    end
                    my_index += 1
                end
                #Fix the json and add back the sports-bra size from tops
                my_json = OrderSize.add_missing_sub_size(temp_json)
                tops = my_json.select{|x| x['name'] == 'tops'}
                #puts sports_bra.inspect
                expect(tops.first['value']).to eql("L")
                
            end   
        end

    end
    
end