#!/usr/bin/env ruby

require_relative './lib/services/web_log_parser'

web_log_parser = WebLogParser.new(ARGV[0])

web_log_parser.execute

puts "\nWeb pages with page counts:\n#{web_log_parser.formatted_web_page_count.join("\n")}"

puts "\nWeb pages with page counts\n#{web_log_parser.formatted_web_page_unique_count.join("\n")}"

puts ""