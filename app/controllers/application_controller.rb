require "rubygems"
require "twitter"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def index
	begin  
		  #render text: "Hello World"
		  
		  @array = [1, 2, 3, 4, 5, 6]
		  @str =''
			@tweets = Array.new
			client = Twitter::Client.new do |config|
				  config.consumer_keyq        = "Tjlc4S9kpOgdfzPFZ19jDQ"
				  config.consumer_secret     = "XeBdBO3tkAD51rwj43KpxYmin1F98FMonu8sAtonAvA"
				  config.access_token        = "998042756-3oinUVcVCrnilSQzsXyp3Bwo8Aw2jbFaj2fiLuUR"
				  config.access_token_secret = "akEMVzQx26MDDqlOqm90Zo4mbV1P5k11j0XW0W5AU"
				end
					
				@retweets = Twitter.user_timeline("BarackObama")
					
				@retweets.each do |tweet|
					@str<< tweet.created_at.asctime
					@str<< tweet.from_user
					@str<<tweet.profile_image_url
					@str<< tweet.text
					@str<< "<br />"
				end
				
				
			
			render :text => @str	
		end
	end
  
end
