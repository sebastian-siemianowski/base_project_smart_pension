# frozen_string_literal: true

require_relative 'web_log_file_reader'
require_relative '../models/web_log_entry'
require_relative '../repositories/web_log_entry_repository'
require 'byebug'

class WebLogParser
  attr_reader :execute_finished
  def initialize(filepath)
    @web_log_file_reader = ::WebLogFileReader.new(filepath)
    @web_log_entry_repository = ::WebLogEntryRepository.new
  end

  def execute
    return if execute_finished

    @web_log_file_reader.execute

    @web_log_file_reader.log_lines.each do |log_line|
      @web_log_entry_repository.add(WebLogEntry.new(page_address: log_line[:page_address], ip_address: log_line[:ip_address]))
    end

    @execute_finished = true
  end

  def formatted_web_page_count
    execute
    web_pages = @web_log_entry_repository.most_popular_web_pages
    web_pages.map { |page| "#{page[0]} #{page[1]} visits" }
  end

  def formatted_web_page_unique_count
    execute
    web_pages = @web_log_entry_repository.most_popular_unique_pages
    web_pages.map { |page| "#{page[0]} #{page[1]} unique visits" }
  end
end
