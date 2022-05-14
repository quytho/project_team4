class AddStatusBorrowToBorrowRequets < ActiveRecord::Migration[6.0]
  def change
    add_column :borrow_requets, :status_borrow, :boolean
  end
end
