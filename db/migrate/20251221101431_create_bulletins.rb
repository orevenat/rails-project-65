# frozen_string_literal: true

class CreateBulletins < ActiveRecord::Migration[8.1]
  def change
    create_table :bulletins do |t|
      t.string :title, limit: 50
      t.text :description, limit: 1000
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
