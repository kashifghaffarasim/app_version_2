class ClassifiedsController < ApplicationController
require 'geocoder'

	def index
		@classifieds = Classified.where(user_id: current_user.id )
	end


	def show
		@classified = Classified.find_by_id(params[:id])
		geocode = "#{@classified.try(:street)},#{@classified.try(:city)},#{@classified.try(:state)},#{@classified.try(:zipcode)}"
		@gecode =  Geocoder.search(geocode)
	end

	def new
		@classified = Classified.new
	end

	def edit
		@classified = Classified.find_by_id(params[:id])
	end
	def create
		@classified = Classified.new(params_classified)
		@classified.user_id= current_user.id 
		if @classified.save 
			if params[:picture][:image]
				if params[:picture][:image].length != 1
					@classified.pictures.create(classified_id: @classified.id,image: params[:picture][:image])
				else
					params[:picture][:image].each { |image|
						@classified.pictures.create(classified_id: @classified.id, image: image)
					}
				end
			end
			redirect_to classifieds_url

		else
			render :new
		end 
		
	end
	def update
		@classified = Classified.find_by_id(params[:id])
		
		if @classified.update(params_classified)
			if params[:picture][:image]
				if params[:picture][:image].length != 1
					@classified.pictures.update(image: params[:picture][:image])
				else
					params[:picture][:image].each { |image|
						@classified.pictures.create(image: image)
					}
				end
			end
			redirect_to classifieds_url
		else
			render :edit
		end
	end
	def destroy
		@classified = Classified.find_by_id(params[:id])

		if @classified.destroy
			redirect_to classifieds_url
		else
			render :index
		end 
	end
	private

	def params_classified
		params.require(:classified).permit(:privacy, :contact_phone, :contact_text, :phone_number, :contact_name, :posting_title, :specific_location, :postal_code, :posting_body,:license_info,:license ,:show_on_map, :street, :city, :state, :zipcode, :user_id,:contact_ok)
	end

	def params_picture
		params.require(:picture).permit(:classified_id ,:image)

	end 

end
