class CollectionsController < ApplicationController
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
    @collection = Collection.where(id: params[:id]).first
    @group = @collection.group

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
