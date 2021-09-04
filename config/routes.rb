# frozen_string_literal: true

::Aranha::Rails::Engine.routes.draw do
  resources(:addresses, concerns: active_scaffold)
  resources(:processor_configurations, concerns: active_scaffold)
  resources(:start_points, concerns: active_scaffold)
end
