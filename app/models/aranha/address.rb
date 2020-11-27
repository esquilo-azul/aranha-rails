# frozen_string_literal: true

require 'eac_ruby_utils/yaml'

module Aranha
  class Address < ::ActiveRecord::Base
    include ::EacRailsUtils::Models::InequalityQueries

    add_inequality_queries(:created_at)

    class << self
      def sanitize_url(url)
        if url.is_a?(Hash)
          ::EacRubyUtils::Yaml.dump(url)
        else
          url.to_s
        end
      end
    end

    validates :url, presence: true, uniqueness: true
    validates :processor, presence: true

    scope :unprocessed, lambda {
      where(processed_at: nil)
    }

    def to_s
      "#{processor}|#{url}"
    end

    def process
      ActiveRecord::Base.transaction do
        instanciate_processor.process
        self.processed_at = Time.zone.now
        save!
      end
    end

    private

    def instanciate_processor
      processor_instancier.call(*processor_instancier_arguments)
    end

    def url_to_process
      ::EacRubyUtils::Yaml.load(url)
    end

    def processor_instancier
      processor.constantize.method(:new)
    end

    def processor_instancier_arguments
      if processor_instancier_arity == 2 || processor_instancier_arity.negative?
        [url_to_process, EacRubyUtils::Yaml.load(extra_data)]
      elsif processor_instancier_arity == 1
        [processor_instancier.call(url_to_process)]
      else
        raise("#{processor}.initialize should has 1 or 2 or * arguments")
      end
    end

    def processor_instancier_arity
      processor.constantize.instance_method(:initialize).arity
    end
  end
end
