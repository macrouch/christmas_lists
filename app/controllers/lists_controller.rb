class ListsController < ApplicationController
  skip_before_filter :is_logged_in, only: [:index]
  def index
  end
end
