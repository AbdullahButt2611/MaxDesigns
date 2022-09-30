class ProjectsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource
	before_action :find_params_project, except: [:project_reports, :project_image_handler_index, :project_status_index, :index, :new, :create]
	before_action :uncomplete_project_data_collect, only: [:index, :project_status_index]
	before_action :complete_project_data_collect, only: [:project_reports]
	before_action :total_project_data_collect, only: [:project_image_handler_index]
	before_action :show_project_data_collect, only: [:show, :see_all_payments]





	def index
	end
	

	def new
		@project = Project.new
		@date_now = Date.current
	end
	
	
	def create
	    @project = Project.new(project_params)
		set_amount_to_zero @project
	    if @project.save
			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	


	def edit
	end
	


	def update
		if @project.update(project_params)
			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	


	def destroy
		@project.destroy
		if params[:redirect]			# Extra param to tell, the request is from a table or show method
			redirect_to projects_path
		else
			render layout: false
		end
  	end



  	def show
		respond_to do |format|
			format.html
			format.pdf do
				render pdf: @project.name+" Details", template: "projects/show_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end



	def project_status_index
	end



	def complete_changer
		respond_to do |format|
			format.js do
				@project.completed!
				render layout: false
			end
		end
	end



	def see_all_payments
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Payment Details By "+current_user.name, template: "projects/see_all_payments_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end



	def see_all_details
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Project Details", template: "projects/see_all_details_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end



	def see_all_order_details
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Order Details By ", template: "projects/see_all_order_details_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end



	def project_image_handler_index
	end
	


	def edit_projects_image
	end



	def put_projects_image
		@image = params[:project][:avatar]
		@project.update(avatar: @image)
		create_project_detail(@project)
		redirect_to project_image_handler_index_path
	end



	def project_reports
		respond_to do |format|
			format.html
			format.pdf do
				@project = Project.find(params[:id])
			  	render pdf: @project.name+" Final Report ", template: "projects/complete_report_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end











	# ========================================================================================================================================================
    # ======================================================        Additional Functions        ==============================================================
    # ========================================================================================================================================================
	
	private

	# Method to allow strong params
  	def project_params
    	params.require(:project).permit(:name, :client_name, :contact, :location, :amount_promised, :deadline, :project_type, :avatar,  :avatar_cache, :remove_avatar)
  	end


	# Method to create the project detail after the updation of image
	def create_project_detail(project)
        project.project_details.create(date: Time.now, task: "A new Image has been updated for the project profile by " + current_user.name + "(" + current_user.user_roles.titleize + ")", user_id: current_user.id)
    end


	def set_amount_to_zero project
		project.amount_present = 0
		set_project_status project
	end


	# This method set the project status to enqueued
	def set_project_status project
		project.project_status = 0
	end





	
	# Data Collection Methods
	def find_params_project
		@project = Project.find(params[:id])
	end



	def uncomplete_project_data_collect
		@projects = Project.not_completed_projects
	end



	def complete_project_data_collect
		@projects = Project.completed_projects
	end



	def total_project_data_collect
		@projects = Project.total_projects
	end



	def show_project_data_collect
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
	end
	

end