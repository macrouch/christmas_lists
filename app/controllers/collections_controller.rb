class CollectionsController < ApplicationController
  include SessionsHelper
  include ListsHelper

  before_action :is_user_member, only: [:show]

  def index
  end

  def show
    @lists_visible = Time.now.month >= 11
    # Display the current user's list first on the show page
    current_user_lists = @collection.lists.where(user: @current_user)
    other_lists = @collection.lists.where.not(id: current_user_lists)
    @lists = current_user_lists
    @lists += other_lists if @lists_visible

    @list_dropdown = @lists.map { |list| [list.name, name_to_id(list.name)] }
    @list_dropdown.unshift ['Select List', '']

    @name_drawing = @collection.name_drawings.where(picker: @current_user).first

    @user_notifications = UserNotification.where(user: @current_user, is_read: false).all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
