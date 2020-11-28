# frozen_string_literal: true

::Aranha::Rails::Engine.routes.draw do
  concern :active_scaffold, ActiveScaffold::Routing::Basic.new(association: true)
  resources(:addresses, concerns: :active_scaffold)
end
