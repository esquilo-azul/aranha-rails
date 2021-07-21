# frozen_string_literal: true

class AddTriesCountToAranhaAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :aranha_addresses, :tries_count, :integer, null: false, default: 0
  end
end
