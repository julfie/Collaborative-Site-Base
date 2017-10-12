class HomeController < ApplicationController
  def home
  	if !logged_in?
  		render layout: 'landing_page'
  	end
  	
  end

  def about
  end

  def privacy
  end

  def contact
  end
end
