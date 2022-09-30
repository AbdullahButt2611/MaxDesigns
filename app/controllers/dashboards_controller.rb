class DashboardsController < ApplicationController
	before_action :authenticate_user!
	before_action :collect_data_model
	
	def index 
	end
	
	






	

# ===============================================================================================================================
# ==================================      Additional Functions Defined      =====================================================
# ===============================================================================================================================
	private
	
	def collect_data_model
		@uncomplete_projects = Project.not_completed_projects.count
		@complete_projects = Project.completed_projects.count
		@all_projects = Project.total_projects.count
		@all_vendors = Vendor.total_vendors_objects.count
		@all_items = Item.total_items_objects.count
		@all_active_users = User.all_active_users.count
		@all_orders = Order.all_order.count
		@unpaid_orders = Order.unpaid_order.count
		@paid_orders = Order.paid_order.count
		@employee_users = User.employee_users.count
		@customer_users = User.customer_users.count
		@pending_users = User.pending_users.count
	end
end