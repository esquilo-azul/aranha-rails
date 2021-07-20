# frozen_string_literal: true

class AddDelayedJobToAranhaAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :aranha_addresses, :delayed_job, foreign_key: false
  end
end
