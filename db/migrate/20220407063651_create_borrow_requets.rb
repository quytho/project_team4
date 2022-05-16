# frozen_string_literal: true

# Borrow Requests Migration
class CreateBorrowRequets < ActiveRecord::Migration[6.0]
  def change
    create_table :borrow_requets do |t|
      t.date :borrow_date, default: Time.now
      t.date :return_date
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
