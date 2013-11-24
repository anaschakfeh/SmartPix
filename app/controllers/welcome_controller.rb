class WelcomeController < ApplicationController
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::DateHelper
  include WelcomeHelper
  #layout 'standard'
  def index
    #    client = Twitter::Client.new do |config|
    #      config.consumer_keyq        = "Tjlc4S9kpOgdfzPFZ19jDQ"
    #      config.consumer_secret     = "XeBdBO3tkAD51rwj43KpxYmin1F98FMonu8sAtonAvA"
    #      config.access_token        = "998042756-3oinUVcVCrnilSQzsXyp3Bwo8Aw2jbFaj2fiLuUR"
    #      config.access_token_secret = "akEMVzQx26MDDqlOqm90Zo4mbV1P5k11j0XW0W5AU"
    #    end
					
  end
  
  def show
    @str =''
    @tweets = Array.new		

    
    begin  
      @strippedpar=strip_control_and_extended_characters(params[:id])
      @retweets = Twitter.user_timeline(@strippedpar)
  
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
  
  
  def generateimage
    @strippedpar=strip_control_and_extended_characters(params[:id])
    @str=""
    @retweets = Twitter.user_timeline(@strippedpar)
    @tweet=@retweets.take(1).first

    template = ERB.new File.new(Rails.root.join("app/views/welcome/tweet.html.erb")).read, nil, "%"
    @renderedtweet = template.result(binding)
    @kit = IMGKit.new(@renderedtweet,:quality => 50,
      :width   => 900,
      :height  => 300)
    #    file = kit.to_file('app/assets/images/'+tweet.from_user+'.png')
    #    respond_to do |format|
    #      format.png do
    send_data(@kit.to_png, :type => "image/png", :disposition => 'inline')
    #      end
    #    end
  end
  
  def strip_control_and_extended_characters(input)
    input.chars.inject("") do |str, char|
      if char.ascii_only? and char.ord.between?(32,126)
        str << char
      end
      str.gsub(/\s+/, "")
    end
  end


  def tweet
    @tweet = Twitter.user_timeline('cnn').take(1).first
  end

  
end
