# frozen_string_literal: true

# Book Categories Migration
class CreateBookCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_categories do |t|
      t.references :category, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end
