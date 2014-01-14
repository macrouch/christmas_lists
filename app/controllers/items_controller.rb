class ItemsController < ApplicationController
  include ListsHelper

  before_action :set_list
  before_action :set_item, only: [:edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.list = @list

    respond_to do |format|
      if @item.save
        format.html { redirect_to lists_url(anchor: name_to_id(@item.list.name)), notice: 'Item created' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to lists_url(anchor: name_to_id(@item.list.name)), notice: 'Item updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to lists_url(anchor: name_to_id(@item.list.name)), notice: 'Item deleted' }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
    @item_comment = ItemComment.new
  end

  def item_params
    params.require(:item).permit(:name, :description, :hidden_from_owner, :purchased, :purchased_by)
  end
end
