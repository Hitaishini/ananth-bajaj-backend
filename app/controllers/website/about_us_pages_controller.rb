class Website::AboutUsPagesController < ApplicationController

	#for getting aboubt us data
	def get_about_us_data
		@about_us = AboutUsPage.all.order("updated_at DESC")

		render json: @about_us
	end

	#for getting 360 degree images
	def model_full_rotate_images
		@model_images = ModelFullImage.all.order("updated_at DESC").collect { |img| img if img.image.present? }

		render json: @model_images
	end

    #for get you tube videl links
	def model_video_links
		@video_links = ModelFullImage.all.order("updated_at DESC").collect { |img| img if img.video_url.present? }

		render json: @video_links
	end
 
end
