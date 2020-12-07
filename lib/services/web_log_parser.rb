class WebLogParser
  def initialize(filepath)
    @web_log_file_reader = WebLogFileReader.new(filepath)
    @web_log_entry_repository = WebLogEntryRepository.new
  end

  def execute
    @web_log_file_reader.execute

    @web_log_file_reader.log_lines.each do |log_line|
      @web_log_entry_repository.add(WebLogEntry.new(page_address: log_line[:page_address], ip_address: log_line[:ip_address]))
    end
  end
end