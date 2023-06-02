# frozen_string_literal: true

class AddPriorityToAranhaProcessorConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :aranha_processor_configurations, :priority, :integer, default: 0, null: false
  end
end
