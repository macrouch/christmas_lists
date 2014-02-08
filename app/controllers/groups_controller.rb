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
    @user = current_user
    @group = Group.where(id: params[:id]).first

    if @user.groups.include?(@group)
      redirect_to groups_path, notice: "You are already a member of #{@group.name}"
    end
  end

  def remove_member
    @user = current_user
    @group = Group.where(id: params[:group_id]).first
    @member = @group.members.where(id: params[:member_id]).first

    respond_to do |format|
      if @group.user == @user
        if @group.members.include?(@member)
          if @group.members.destroy(@member)
            format.html { redirect_to groups_path, notice: "#{@member.name} successfully removed from #{@group.name}" }
          else
            format.html { redirect_to groups_path, alert: "#{@member.name} could not be removed from #{@group.name}" }
          end
        else
          format.html { redirect_to groups_path, alert: "#{@member.name} is not a member of #{@group.name}" }
        end
      else
        format.html { redirect_to groups_path, alert: "You can't remove your self from #{@group.name}" }
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :question, :answer)
  end
end