class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    respond_to do |format|
      if @group.save
        current_user.groups << @group

        collection = Collection.new({name: Time.now.year, group: @group})
        collection.save
        format.html { redirect_to groups_path, notice: 'Group created'}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def join
    @group = Group.where(id: params[:id]).first
  end

  private

  def group_params
    params.require(:group).permit(:name, :question, :answer)
  end
end
