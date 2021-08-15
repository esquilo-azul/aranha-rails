# frozen_string_literal: true

class AddEnabledToAranhaProcessorConfigurations < ActiveRecord::Migration[5.1]
  def change
    add_column :aranha_processor_configurations, :enabled, :boolean, default: true, null: false
  end
end
