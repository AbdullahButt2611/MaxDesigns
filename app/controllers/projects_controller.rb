class ProjectsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		@projects = Project.not_completed_projects
	end
	
	def new
		@project = Project.new
		@date_now = Date.current
	end
	
	def create
	    @project = Project.new(project_params)
		@project.amount_present = 0
	    if @project.valid?
		    @project.enqueued!			# To change the status of the project
		end
	    if @project.save

			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	
	def edit
		@project = Project.find(params[:id])
	end
	
	def update
		@project = Project.find(params[:id])

		if @project.update(project_params)
			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	
	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		if params[:redirect]
			redirect_to projects_path
		else
			render layout: false
		end
  	end

  	def show
	    @project = Project.find(params[:id])
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Details", template: "projects/show_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		  end
	end

	def project_status_index
		@projects = Project.not_completed_projects
	end

	def complete_changer
		@project = Project.find(params[:id])
		respond_to do |format|
			format.js do
				@project.completed!
				render layout: false
			end
		end
	end

	def see_all_payments
		@project = Project.find(params[:id])
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Payment Details By "+current_user.name, template: "projects/see_all_payments_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end


	def see_all_details
		@project = Project.find(params[:id])
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Project Details", template: "projects/see_all_details_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end


	def see_all_order_details
		@project = Project.find(params[:id])
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
		respond_to do |format|
			format.html
			format.pdf do
			  render pdf: @project.name+" Order Details By ", template: "projects/see_all_order_details_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end

	def project_image_handler_index
		@projects = Project.total_projects
	end
	
	def edit_projects_image
		@project = Project.find(params[:id])
	end

	def put_projects_image
		@project = Project.find(params[:id])
		@image = params[:project][:avatar]
		@project.update(avatar: @image)
		create_project_detail(@project)
		redirect_to project_image_handler_index_path
	end

	def project_reports
		@projects = Project.completed_projects
		respond_to do |format|
			format.html
			format.pdf do
				@project = Project.find(params[:id])
			  	render pdf: @project.name+" Final Report ", template: "projects/complete_report_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
			end
		end
	end


	private
  	def project_params
    	params.require(:project).permit(:name, :client_name, :contact, :location, :amount_promised, :deadline, :project_type, :avatar,  :avatar_cache, :remove_avatar)
  	end

	  def create_project_detail(project)
        project.project_details.create(date: Time.now, task: "A new Image has been updated for the project profile by " + current_user.name + "(" + current_user.user_roles.titleize + ")", user_id: current_user.id)
    end

	

end