# frozen_string_literal: true

module JekyllOptionalFrontMatterCollection
  class Generator < Jekyll::Generator
    attr_accessor :site

    safe true
    priority :normal

    CONFIG_KEY = "optional_front_matter_collection"
    ENABLED_KEY = "enabled"
    CLEANUP_KEY = "remove_originals"
    COLLECTIONS_KEY = "collections"

    def initialize(site)
      @site = site
    end

    def generate(site)
      @site = site
      return if disabled?

      collections.each do |collection|
        site.collections[collection].docs.concat(pages_to_add(collection))
        site.static_files -= static_files_to_remove(collection) if cleanup?
      end
    end

    private

    # An array of Jekyll::Pages to add, *excluding* blacklisted files
    def pages_to_add(collection_name)
      pages(collection_name).reject { |page| blacklisted?(page) }
    end

    # An array of Jekyll::StaticFile's, *excluding* blacklisted files
    def static_files_to_remove(collection_name)
      markdown_files(collection_name).reject { |page| blacklisted?(page) }
    end

    # An array of potential Jekyll::Pages to add, *including* blacklisted files
    def pages(collection_name)
      markdown_files(collection_name).map { |static_file| doc_from_static_file(static_file) }
    end

    # An array of Jekyll::StaticFile's with a site-defined markdown extension
    def markdown_files(collection_name)
      site.static_files.select { |file| markdown_converter.matches(file.extname) && file.relative_path =~ /^_#{collection_name}/ }
    end

    # Given a Jekyll::StaticFile, returns the file as a Jekyll::Page
    def doc_from_static_file(static_file)
      document = Jekyll::Document.new(static_file.path, site: site, collection: site.collections['notes'])

      data = {
        'title' => File.basename(static_file.path, ".*"),
      }

      document.merge_data!(static_file.data)
      document.merge_data!(data)
      document.content = File.read(static_file.path)
      document
    end

    # Does the given Jekyll::Page match our filename blacklist?
    def blacklisted?(page)
      return false if whitelisted?(page)

      FILENAME_BLACKLIST.include?(page.basename.upcase)
    end

    def whitelisted?(page)
      return false unless site.config["include"].is_a? Array

      entry_filter.included?(page.relative_path)
    end

    def markdown_converter
      @markdown_converter ||= site.find_converter_instance(Jekyll::Converters::Markdown)
    end

    def entry_filter
      @entry_filter ||= Jekyll::EntryFilter.new(site)
    end

    def option(key)
      site.config[CONFIG_KEY] && site.config[CONFIG_KEY][key]
    end

    def disabled?
      option(ENABLED_KEY) == false || site.config["require_front_matter"]
    end

    def cleanup?
      option(CLEANUP_KEY) == true || site.config["require_front_matter"]
    end

    def collections
      option(COLLECTIONS_KEY) || site.config["collections"] || []
    end
  end
end