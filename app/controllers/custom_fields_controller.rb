class CustomFieldsController < ApplicationController

	def index 
		@custom_fields = CustomField.where(user_id: current_user.id)
	end

	def new 
		@custom_field = CustomField.new
	end 

	def create 
		@custom_field = CustomField.new(params_custom_field)
		@custom_field.default = params[:custom_field][:default]
		@custom_field.user_id = current_user.id
		@custom_fields = CustomField.where(user_id: current_user.id)

		if @custom_field.save 
			flash[:success] = "Custom Field Successfully Saved" 
		else 
			flash[:danger] = "Custom Field Not Save Try Again"
		end 

	end 

	def edit 
		@custom_field = CustomField.find_by_id(params[:id])
	end 


	def update 
		@custom_field = CustomField.find_by_id(params[:id])
		@custom_fields = CustomField.where(user_id: current_user.id)

		if @custom_field.update(params_custom_field)
			@custom_field.update(default: params[:custom_field][:default])

			flash[:success] = "Custom Field Successfully Update" 
			render "create.js.erb"

		else 
			flash[:danger] = "Custom Field Not Update Try Again"
			render "create.js.erb"

		end 
	end 

	def destroy 
		@custom_field = CustomField.find_by_id(params[:id])
		@custom_fields = CustomField.where(user_id: current_user.id)

		if @custom_field.destroy
			flash[:success] = "Custom Field Successfully to Delete" 
			render "create.js.erb"
		else 
			flash[:danger] = "Custom Field Not Delete Try Again"
			render "create.js.erb"

		end 
	end  

	private 
	def params_custom_field
		params.require(:custom_field).permit(:applies_to,:name,:value_type,:user_id,:default)
	end
end
