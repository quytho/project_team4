# frozen_string_literal: true

# Books Migration
class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :amount
      t.boolean :status
      t.integer :price
      t.references :author, foreign_key: true
      t.references :publisher, foreign_key: true
      t.timestamps
    end
  end
end
