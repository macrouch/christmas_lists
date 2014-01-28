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
        format.html { redirect_to collection_url(@collection, anchor: name_to_id(@item.list.name)), notice: 'Item created' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    if params[:remove_image]
      remove_image
    else
      respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to collection_url(@collection, anchor: name_to_id(@item.list.name)), notice: 'Item updated' }
        else
          format.html { render action: 'edit' }
        end
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to collection_url(@collection, anchor: name_to_id(@item.list.name)), notice: 'Item deleted' }
    end
  end

  def remove_image
    @item.image = nil

    respond_to do |format|
      if @item.save
        format.html { redirect_to edit_collection_list_item_path(@collection, @list, @item), notice: 'Image removed' }
      else
        format.html { redirect_to edit_collection_list_item_path(@collection, @list, @item), alert: 'Image removed failed' }
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_list
    @collection = Collection.where(id: params[:collection_id]).first
    @list = List.find(params[:list_id])
    @item_comment = ItemComment.new
  end

  def item_params
    params.require(:item).permit(:name, :description, :hidden_from_owner, :purchased, :purchased_by, :image)
  end
end
