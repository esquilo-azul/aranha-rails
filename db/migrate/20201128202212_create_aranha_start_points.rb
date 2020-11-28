# frozen_string_literal: true

class CreateAranhaStartPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :aranha_start_points do |t|
      t.string :uri
      t.string :processor_class
      t.string :extra_data_yaml

      t.timestamps
    end
  end
end
