module BooksHelper
  def average_rating (book)
    average = book.ratings.average(:rate) || 0
    average = average.round if average.is_a?(Float) || average.is_a?(BigDecimal)
    average
  end
end
