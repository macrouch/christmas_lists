class IdentitiesController < ApplicationController
  skip_before_filter :is_logged_in, :only => [:new]
  layout "non_user"

  def new
    @identity = env["omniauth.identity"]
  end
end
