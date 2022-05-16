# frozen_string_literal: true

# Users Migration
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :password_digest
      t.boolean :is_admin, default: false
      t.timestamps
    end
  end
end
