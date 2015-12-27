class ListsController < ApplicationController
  include ListsHelper
  include SessionsHelper

  before_action :is_user_member
  before_action :set_collection, only: [:new, :edit, :create, :update]
  before_action :set_list, only: [:show, :edit, :update]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)
    @list.collection = @collection

    respond_to do |format|
      if @list.save
        format.html { redirect_to collection_url(@collection, anchor: name_to_id(@list.name)), notice: 'List created' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to collection_url(@collection, anchor: name_to_id(@list.name)), notice: 'List updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def set_collection
    @collection = Collection.find(params[:collection_id])
    @users = @collection.group.members.order('name')
  end

  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
