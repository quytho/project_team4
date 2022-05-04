module BooksHelper
  def star(book)
    sum = book.rates.map(&:star).sum
    avg = book.rates.map(&:star).count
    star = sum / avg rescue 0
  end
end
