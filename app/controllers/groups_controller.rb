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
        format.html { redirect_to groups_path, notice: 'Group created. To invite people to your group, click on the "Options" tab for your group below.'}
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
    @group = Group.find(params[:id])

    if !@user.active && @user.original_url
      redirect_to root_url, alert: 'You must activate your account before you can join groups'
    end
    if @user.groups.include?(@group)
      redirect_to groups_path, notice: "You are already a member of #{@group.name}"
    end
  end

  def remove_member
    @user = current_user
    @group = Group.find(params[:group_id])
    @member = User.find(params[:member_id])

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

  def invite
    user = current_user
    @group = Group.find(params[:group_id])
    emails = params[:group][:emails].split("\r\n")

    respond_to do |format|
      UserMailer.invitation_email(user, @group, emails).deliver
      format.html { redirect_to groups_path, notice: 'Invitation email sent' }
    end
  end

  def draw_names
    @group = Group.find(params[:id])
  end

  def save_sub_groups
    @group = Group.find(params[:id])
    @group.sub_groups.destroy_all

    params[:sub_groups].each do |group|
      member_ids = group[1].map(&:to_i)
      members = User.where(id: member_ids)

      sub_group = @group.sub_groups.create
      sub_group.members = members
      sub_group.save
    end

    redirect_to :draw_names
  end

  def do_draw_names
    @group = Group.find(params[:id])
    @group.draw_names
    redirect_to :draw_names
  end

  def create_next_collection
    @group = Group.find(params[:id])

    last_collection = @group.collections.first
    new_collection = @group.collections.create(name: last_collection.name.to_i + 1)

    last_collection.lists.each do |list|
      new_collection.lists << List.create(user_id: list.user_id, name: list.name)
    end

    redirect_to new_collection
  end

  private

  def group_params
    params.require(:group).permit(:name, :question, :answer)
  end
end
