class RatingsController < ApplicationController
  before_action :authenticate_customer!
  load_and_authorize_resource
  
  def create
    book = Book.find(params[:book_id])
    @rating.book = book
    @rating.attributes = rating_params
    if @rating.save
      flash[:notice] = "Your review has been added"
    else
      flash[:alert] = @rating.errors.full_messages
    end
    redirect_to book_path(id: book)
  end
  private
  def rating_params
    params.require(:rating).permit(:text, :rate)
  end
end
