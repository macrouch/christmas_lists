class CollectionsController < ApplicationController
  include SessionsHelper

  before_action :is_user_member, only: [:show]

  def index
    @groups = current_user.groups
    if @groups.empty?
      redirect_to groups_path
      return
    end

    @collections = @groups.first.collections

    redirect_to collection_path(@collections.last)
  end

  def show
    @lists = @collection.lists
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
