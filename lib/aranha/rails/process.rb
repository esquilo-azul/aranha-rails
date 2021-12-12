# frozen_string_literal: true

module Aranha
  module Rails
    class Process
      QUEUE = 'aranha'
      QUEUES = [QUEUE].freeze

      enable_listable
      lists.add_symbol :option, :limit

      common_constructor :options, default: [{}] do
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      def run
        run_init
        run_jobs_workoff
        run_close
      end

      def limit
        options[OPTION_LIMIT].if_present(-1, &:to_i)
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
        worker = ::Delayed::Worker.new(exit_on_complete: true, queues: QUEUES)
        limit.negative? ? worker.start : worker.work_off(limit)
      end
    end
  end
end
