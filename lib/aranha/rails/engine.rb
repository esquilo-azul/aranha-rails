# frozen_string_literal: true

require 'active_scaffold'
require 'eac_rails_delayed_job/engine'

module Aranha
  module Rails
    class Engine < ::Rails::Engine
      include ::EacRailsUtils::EngineHelper

      isolate_namespace ::Aranha
    end
  end
end
