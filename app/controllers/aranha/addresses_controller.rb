# frozen_string_literal: true

module Aranha
  class AddressesController < ::ApplicationController
    active_scaffold :'aranha/address' do |conf|
      conf.actions.exclude :create, :update
    end
  end
end
