module SessionsHelper
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def is_user_member
    if params[:controller] == 'collections'
      @collection = Collection.find(params[:id])
    else
      @collection = Collection.find(params[:collection_id])
    end
    @group = @collection.group

    unless @group.members.include?(current_user)
      flash[:error] = "You are not a member of that group"
      redirect_to root_url
    end
  end

  private

  def clear_return_to
    session.delete(:return_to)
  end
end
