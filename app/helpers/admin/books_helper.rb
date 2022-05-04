module Admin::BooksHelper
  def current(book)
    current_borrow = book.borrow_requets.map(&:book_id).count
    current_quantity = book.amount - current_borrow
  end
end