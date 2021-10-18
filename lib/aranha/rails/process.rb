# frozen_string_literal: true

module Aranha
  module Rails
    class Process
      QUEUE = 'aranha'
      QUEUES = [QUEUE].freeze

      def run
        run_init
        run_jobs_workoff
        run_close
      end

      private

      def run_close
        ::Aranha::Address.failed.each do |a|
          ::Rails.logger.warn "Failed \"#{a.url}\": #{a.last_error}"
        end
        raise 'Some address failed' if ::Aranha::Address.failed.any?
      end

      def run_init
        ::Aranha::Manager.default.init
        ::Aranha::Address.all.each(&:init_scheduling)
      end

      def run_jobs_workoff
        ::Delayed::Worker.new(exit_on_complete: true, queues: QUEUES).start
      end
    end
  end
end
