class ItemCommentsController < ApplicationController
  def create
    @item_comment = ItemComment.new(item_comment_params)

    respond_to do |format|
      if @item_comment.save
        format.html { redirect_to edit_list_item_path(@item_comment.list, @item_comment.item), notice: 'Comment created' }
      else
        format.html { redirect_to edit_list_item_path(@item_comment.list, @item_comment.item), alert: 'Comment could not be created' }
      end
    end
  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment, :private, :item_id, :user_id)
  end
end
