# frozen_string_literal: true

require 'eac_ruby_utils/yaml'

module Aranha
  class StartPoint < ::ActiveRecord::Base
    class << self
      def add_processor_class(klass)
        processor_class_list_var.add(klass.to_s)
      end

      def processor_class_list
        processor_class_list_var.to_enum
      end

      def processor_class_options
        processor_class_list.map { |e| [e, e] }.to_h
      end

      private

      def processor_class_list_var
        @processor_class_list_var ||= Set.new
      end
    end

    validates :uri, presence: true, uniqueness: true, # rubocop:disable Rails/UniqueValidationWithoutIndex
                    format: { with: ::URI::DEFAULT_PARSER.make_regexp }
    validates :processor_class, presence: true
    validate :processor_class_in_list

    def extra_data
      extra_data_yaml.nil? ? nil : ::EacRubyUtils::Yaml.load(extra_data_yaml)
    end

    def extra_data=(value)
      self.extra_data_yaml = ::EacRubyUtils::Yaml.dump(value)
    end

    def processor_class_in_list
      return if processor_class.blank?
      return if self.class.processor_class_list.include?(processor_class)

      errors.add(:processor_class, 'Not in list')
    end
  end
end
