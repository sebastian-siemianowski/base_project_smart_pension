class WebLogEntryRepository
  attr_reader :all

  def initialize
    @all = []
  end

  def add(web_log_entry)
    return unless web_log_entry.is_a?(WebLogEntry)

    @all << web_log_entry if web_log_entry.valid?
  end
end