# frozen_string_literal: true

namespace(:aranha) do # rubocop:disable Metrics/BlockLength
  desc 'Process Aranha\'s addresses.'
  task :process, %i[limit] => :environment do |_t, args|
    ::Aranha::Rails::Process.new(limit: args.limit).run
  end

  desc 'Remove all registered Aranha\'s addresses.'
  task clear: :environment do
    Rails.logger.info("Addresses deleted: #{::Aranha::Address.destroy_all.count}")
  end

  namespace :address do
    desc 'Process a arbitrary address.'
    task :process, %i[uri processor] => :environment do |_t, args|
      args.processor.constantize.new(args.uri, {}).process
    end
  end

  namespace :fixtures do
    desc 'Download remote content for fixtures.'
    task download: :environment do
      require 'aranha/rails/fixtures_download'

      ::Aranha::Rails::FixturesDownload.new(
        ::Aranha::Rails::FixturesDownload::OPTION_EXTENSION => ENV.fetch('EXTENSION', nil),
        ::Aranha::Rails::FixturesDownload::OPTION_PREFIX => ENV.fetch('PREFIX', nil),
        ::Aranha::Rails::FixturesDownload::OPTION_DOWNLOAD => ENV['DOWNLOAD'].present?,
        ::Aranha::Rails::FixturesDownload::OPTION_PENDING => ENV['PENDING'].present?
      ).run
    end
  end
end
