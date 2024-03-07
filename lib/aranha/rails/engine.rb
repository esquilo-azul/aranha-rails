# frozen_string_literal: true

require 'eac_active_scaffold/engine'
require 'eac_rails_delayed_job/engine'
require 'eac_rails_utils/engine'

module Aranha
  module Rails
    class Engine < ::Rails::Engine
      include ::EacRailsUtils::EngineHelper

      isolate_namespace ::Aranha
    end
  end
end

require 'aranha/rails/patches/delayed_job'
