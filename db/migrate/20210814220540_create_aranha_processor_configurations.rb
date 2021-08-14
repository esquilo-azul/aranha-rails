# frozen_string_literal: true

class CreateAranhaProcessorConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :aranha_processor_configurations do |t|
      t.string :processor_class
      t.integer :timeout_seconds, null: true

      t.timestamps null: false
    end
  end
end
