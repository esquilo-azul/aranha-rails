# frozen_string_literal: true

::Rails.application.root_menu.group(:admin).group(:aranha, :aranha).within do |g|
  g.action(:addresses).label(-> { ::Aranha::Address.plural_name })
  g.action(:processor_configurations)
    .label(-> { ::Aranha::ProcessorConfiguration.plural_name })
  g.action(:start_points).label(-> { ::Aranha::StartPoint.plural_name })
end
