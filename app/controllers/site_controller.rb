class SiteController < ApplicationController
  def index
    @books = Book.all.limit(12)
  end

  def about
  end

  def contact
  end
end
