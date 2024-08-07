# frozen_string_literal: true

require 'fileutils'
require 'i18n'
require 'lite_logger'
require 'pdf-reader'
require 'time'

I18n.config.available_locales = :en

class BooksRenamer
  FILE_PATTERNS = ['*.pdf'].freeze

  def initialize(directory, update: false, logger: LiteLogger::Logger.new)
    @directory = directory
    @update = update
    @logger = logger
  end

  def rename_books
    FILE_PATTERNS.each do |pattern|
      Dir.glob(File.join(@directory, pattern)).each do |file_path|
        process_file(file_path)
      end
    end
  end

  private

  def process_file(file_path)
    file_path_basename = File.basename(file_path)
    title, author = fetch_metadata(file_path)
    handle_rename(file_path, file_path_basename, title, author)
  rescue StandardError => e
    @logger.error("Processing #{file_path_basename} failed - #{e.message}")
  end

  def handle_rename(file_path, file_path_basename, title, author)
    return @logger.info("SKIP: #{file_path_basename} - metadata missing") if title.to_s.empty? || author.to_s.empty?

    new_file_name = format_name(title, author, File.extname(file_path))
    return @logger.info("NOOP: #{file_path_basename} - no rename needed") if new_file_name == file_path_basename

    perform_rename(file_path, file_path_basename, new_file_name)
  end

  def perform_rename(file_path, old_name, new_name)
    new_file_path = File.join(@directory, new_name)
    if new_file_path != file_path && @update && File.exist?(file_path)
      FileUtils.mv(file_path, new_file_path)
      @logger.info("RENAME: #{old_name} -> #{new_name}")
    else
      @logger.info("DRYRUN: would rename #{old_name} -> #{new_name}") unless new_file_path == file_path
    end
  end

  def fetch_metadata(file_path)
    reader = PDF::Reader.new(file_path)
    [convert_to_utf8(reader.info[:Title]), convert_to_utf8(reader.info[:Author])]
  end

  def convert_to_utf8(str)
    str&.force_encoding('ISO-8859-1')&.encode('UTF-8')
  end

  def format_name(title, author, extension)
    return nil if title.nil? || author.nil?

    "#{sanitize_filename(title)} - #{sanitize_filename(author)}#{extension}"
  end

  def sanitize_filename(name)
    I18n.transliterate(name).gsub(/[^0-9A-Za-z.\-]/, ' ').squeeze(' ').strip
  end
end
