# frozen_string_literal: true

require 'active_scaffold'

module Aranha
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace ::Aranha

      initializer :append_migrations do |app|
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end
  end
end
