class CollectionsController < ApplicationController
  include SessionsHelper

  before_action :is_user_member, only: [:show]

  def index
  end

  def show
    @lists = @collection.lists
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
