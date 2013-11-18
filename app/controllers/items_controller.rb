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
    list_item = ListItem.new(list: @list, item: @item, visible_to_owner: true)

    respond_to do |format|
      if @item.save && list_item.save
        format.html { redirect_to @list }
      else
        format.html { render action: 'new'}
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @list }
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
    params.require(:item).permit(:name, :description)
  end
end
