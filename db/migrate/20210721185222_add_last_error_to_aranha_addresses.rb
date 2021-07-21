# frozen_string_literal: true

class AddLastErrorToAranhaAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :aranha_addresses, :last_error, :text
  end
end
