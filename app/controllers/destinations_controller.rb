class DestinationsController < ApplicationController
  def show
    @bookmark_destination = current_user.bookmark_destinations.find(params[:id])
  end

  def bookmarks
    @bookmark_destinations = current_user.bookmark_destinations.order(created_at: :desc).page(params[:page])
  end
end
