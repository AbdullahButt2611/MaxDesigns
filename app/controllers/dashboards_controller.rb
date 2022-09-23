class DashboardsController < ApplicationController
	before_action :authenticate_user!
	
	def index 
		@uncomplete_projects = Project.not_completed_projects.count
		@complete_projects = Project.completed_projects.count
		@all_projects = Project.total_projects.count
		@all_vendors = Vendor.total_vendors_objects.count
		@all_items = Item.total_items_objects.count
		@all_active_users = User.all_active_users.count
	end
end