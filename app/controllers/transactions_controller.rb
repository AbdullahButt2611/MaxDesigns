class TransactionsController < ApplicationController
  before_action :authenticate_user!
	load_and_authorize_resource
  
    def create
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @check = check_amount_present(@project, @order)
        
        if @check
          Transaction.create(amount_paid: calculate_total_sum_of_order(@order), date: DateTime.now, order_id: @order.id, user_id: current_user.id)
          @project.update(amount_present: @project.amount_present - calculate_total_sum_of_order(@order))
          change_type_of_order(@order)
          create_project_detail(@order)
          create_vendors_history(@order)
          
        end
        render layout: false
    end

    def user_based_transactions
      @user_transactions_data = Transaction.current_users_transactions_added(current_user.id)
    end



    private  
  
    def find_item(vendor_id, item_id)
      vendor = Vendor.find(vendor_id)
      item = vendor.items.find(item_id)
      return item
    end
  
    def find_vendor(vendor_id)
      vendor = Vendor.find(vendor_id)
      return vendor.company_name
    end
  
    def sum_price_calculator(vendor_id, item_id, quantity)
      vendor = Vendor.find(vendor_id)
      item = vendor.items.find(item_id)
      sum = item.price * quantity
      return sum
    end
  
    def calculate_total_sum_of_order(order)
      price = 0
      order.order_details.each do |detail|
        item = find_item(detail.vendor_id, detail.item_id)
        value = item.price * detail.quantity
        price += value
      end
      return price
    end

    def change_type_of_order(order)
        order.paid!
    end

    def check_amount_present(project, order)
        return project.amount_present > calculate_total_sum_of_order(order)
    end

    def create_project_detail(order)
        order.project.project_details.create(date: Time.now, task: "The order's bill has been paid for the order ref# " + order.id.to_s, user_id: current_user.id)
    end

    def vendor_based_calculation(details)
		counts = Hash.new

		details.each do |detail|
			if counts.key?(detail.vendor_id)
				counts[detail.vendor_id] = counts.fetch(detail.vendor_id) + sum_price_calculator(detail.vendor_id, detail.item_id, detail.quantity)
			else 
				counts.store(detail.vendor_id, sum_price_calculator(detail.vendor_id, detail.item_id, detail.quantity))
			end
		end
		return counts
	end

    def create_vendors_history(order)
        counts = vendor_based_calculation(order.order_details)
        counts.each do |v_id, sum_val|
            VendorHistory.create(order_id: order.id, vendor_id: v_id, amount: calculate_total_sum_of_order(order), date: DateTime.now)
        end
    end


    
end