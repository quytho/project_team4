module BooksHelper
  def star(book)
    sum = book.rates.map(&:star).sum
    avg = book.rates.map(&:star).count
    begin
      sum / avg
    rescue StandardError
      0
    end
  end
end
