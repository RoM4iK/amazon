class BooksController < ApplicationController
  layout "with_sidebar"

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @page_title = @book.title
  end

  def category
    @category = Category.find(params[:category])
    @books = Book.where(category: @category).limit(12)
  end

  private
    def book_params
      params[:book]
    end
end
