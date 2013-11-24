class ItemsController < ApplicationController
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
        format.html { redirect_to lists_url, notice: 'Item created' }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to lists_url, notice: 'Item updated' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :visible_to_owner, :purchased, :purchased_by)
  end
end
