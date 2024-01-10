class DestinationsController < ApplicationController
  def bookmarks
    @bookmark_destinations = current_user.bookmark_destinations.order(created_at: :desc).page(params[:page])
  end
end
