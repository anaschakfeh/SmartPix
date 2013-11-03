class WelcomeController < ApplicationController
  #layout 'standard'
  def index
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
  end
  
  def show
    @str =''
    @tweets = Array.new
    client = Twitter::Client.new do |config|
      config.consumer_keyq        = "Tjlc4S9kpOgdfzPFZ19jDQ"
      config.consumer_secret     = "XeBdBO3tkAD51rwj43KpxYmin1F98FMonu8sAtonAvA"
      config.access_token        = "998042756-3oinUVcVCrnilSQzsXyp3Bwo8Aw2jbFaj2fiLuUR"
      config.access_token_secret = "akEMVzQx26MDDqlOqm90Zo4mbV1P5k11j0XW0W5AU"
    end
					
    
    begin  
      @retweets = Twitter.user_timeline(params[:id])
  
      if @retweets.blank?
        @str<< "<div style='color:red'>Tweets can not be fetched. Either the twitter name does not exist or the account has denied permossion</div> <br />"
      else
      
        @retweets.take(1).each do |tweet|
          @str<<"<img src="+tweet.profile_image_url+ "/><br />"
          @str<< tweet.from_user+"<br />"
          @str<< tweet.text+"<br />"
          @str<< tweet.created_at.asctime+"<br />"
          @str<< "<br />"
          
      
          if User.where("\"twitterName\" ILIKE ?", tweet.from_user).blank?
      
            @user = User.new(twitterName: tweet.from_user,name: tweet.from_user)
 
            @user.save
     
          else
      
            @str<< "<div style='color:red'>User already exists</div> <br />"
       
          end
      
        end
      
      end
    
    rescue  
     @str<< "<div style='color:red'>Tweets can not be fetched. Either the twitter name does not exist or the account has denied permossion</div> <br />"
    end  	
      
        
    render :text => @str
  end
  
end
