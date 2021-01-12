# frozen_string_literal: true

class CreateWildberries < ActiveRecord::Migration[6.1]
  def change
    create_table :wildberries do |t|
      t.integer :quantity, null: false, default: 0
      t.integer :quantity_full, null: false, default: 0
      t.integer :quantity_not_in_orders, null: false, default: 0
      t.string :warehouse_name, null: true, default: nil
      t.integer :in_way_to_client, null: false, default: 0
      t.integer :in_way_from_client, null: false, default: 0
      t.string :subject, null: true, default: nil
      t.string :category, null: true, default: nil
      t.string :brand, null: true, default: nil
      t.monetize :price, null: false, default: 0
      t.integer :nmid, null: false
      t.datetime :last_change_date, null: true, default: nil

      t.timestamps
    end
  end
end
