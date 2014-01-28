class CollectionsController < ApplicationController
  def index
    @families = current_user.families
    if @families.empty?
      redirect_to families_path 
      return
    end

    @collections = @families.first.collections
  end

  def show
    @collection = Collection.where(id: params[:id]).first

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
