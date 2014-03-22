class CollectionsController < ApplicationController
  include SessionsHelper
  include ListsHelper

  before_action :is_user_member, only: [:show]

  def index
  end

  def show
    @lists = @collection.lists
    @list_dropdown = @lists.map{ |list| [list.name, name_to_id(list.name)] }
    @list_dropdown.unshift ["Select List", ""]
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
