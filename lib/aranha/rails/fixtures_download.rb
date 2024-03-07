# frozen_string_literal: true

require 'aranha/parsers/base'
require 'aranha/parsers/source_address'
require 'aranha/parsers/source_target_fixtures'
require 'eac_ruby_utils/core_ext'

module Aranha
  module Rails
    class FixturesDownload
      DEFAULT_EXTENSION = '.html'

      enable_listable
      lists.add_symbol :option, :extension, :prefix, :download, :pending

      common_constructor :options do
        self.options = self.class.lists.option.hash_keys_validate!(options)
      end

      def download?
        options[OPTION_DOWNLOAD] ? true : false
      end

      def extension
        options[OPTION_EXTENSION].if_present(DEFAULT_EXTENSION)
      end

      def pending?
        options[OPTION_PENDING] ? true : false
      end

      def prefix
        options[OPTION_PREFIX].if_present('')
      end

      def run
        url_files.each do |f|
          ::Rails.logger.info(relative_path(f))
          download(url(f), target(f)) if download?
        end
      end

      private

      def url_files
        Dir["#{fixtures_root}/**/*.url"].select { |path| select_path?(path) }
      end

      def select_path?(path)
        return false unless match_prefix_pattern(path)

        !pending? || !source_exist?(path)
      end

      def match_prefix_pattern(path)
        relative_path(path).start_with?(prefix)
      end

      def fixtures_root
        ::Rails.root.to_s
      end

      def download(url, target)
        ::Rails.logger.info "Baixando \"#{url}\"..."
        content = ::Aranha::Parsers::Base.new(url).content
        raise "Content is blank for \"#{url}\"" if content.blank?

        File.binwrite(target, content)
      end

      def url(file)
        ::Aranha::Parsers::SourceAddress.from_file(file)
      end

      def target(file)
        File.expand_path(File.basename(file, '.url') + '.source' + extension, File.dirname(file)) # rubocop:disable Style/StringConcatenation
      end

      def relative_path(path)
        path.sub(%r{^#{Regexp.quote(fixtures_root)}/}, '')
      end

      def source_exist?(path)
        stf = ::Aranha::Parsers::SourceTargetFixtures.new(::File.dirname(path))
        stf.source_file(::File.basename(path, '.url')).present?
      end
    end
  end
end
