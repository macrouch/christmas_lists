class IdentitiesController < ApplicationController
  skip_before_filter :is_logged_in, :only => [:new]
  
  def new
    @identity = env["omniauth.identity"]
    render :layout => "non_user"
  end
end
