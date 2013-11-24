class ListsController < ApplicationController
  include ListsHelper
  
  before_action :set_list, only: [:show, :edit, :update]

  def index
    @lists = List.all
  end

  def show  
  end

  def new
    @list = List.new
    @users = User.all.order(:name)
  end

  def edit
    @users = User.all.order(:name)
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_url(anchor: name_to_id(@list.name)), notice: 'List created' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_url(anchor: name_to_id(@list.name)), notice: 'List updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
