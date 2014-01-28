class FamiliesController < ApplicationController
  def index
    @families = current_user.families
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @family.user = current_user

    respond_to do |format|
      if @family.save
        current_user.families << @family

        collection = Collection.new({name: Time.now.year, family: @family})
        collection.save
        format.html { redirect_to families_path, notice: 'Family created'}
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

  private

  def family_params
    params.require(:family).permit(:name, :question, :answer)
  end
end
