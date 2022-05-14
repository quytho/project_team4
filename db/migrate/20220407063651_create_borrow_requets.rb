class CreateBorrowRequets < ActiveRecord::Migration[6.0]
  def change
    create_table :borrow_requets do |t|
      t.date :borrow_dat
      t.date :return_date
      t.integer :status
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    change_column_default(
      borrow_requets,
      status,
      0
    )
  end
end
