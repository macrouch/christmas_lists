class ItemCommentsController < ApplicationController
  include SessionsHelper

  before_action :is_user_member

  def create
    item = Item.find(params[:item_comment][:item_id])
    @item_comment = ItemComment.new(item_comment_params)
    @item_comment.item = item
    list = @item_comment.list
    collection = list.collection

    respond_to do |format|
      if @item_comment.save
        format.html { redirect_to edit_collection_list_item_path(collection, list, item), notice: 'Comment created' }
      else
        format.html { redirect_to edit_collection_list_item_path(collection, list, item), alert: 'Comment could not be created' }
      end
    end
  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment, :private, :item_id, :user_id)
  end
end
