class WebLogEntryRepository
  attr_reader :all, :cache_expired

  def initialize
    @all = []
    @cache_valid = true
  end

  def add(web_log_entry)
    return unless web_log_entry.is_a?(WebLogEntry)

    if web_log_entry.valid?
      @all << web_log_entry
      @cache_valid = false
    end
  end

  def most_popular_web_pages
    if @most_popular_web_pages && @cache_valid
      return @most_popular_web_pages
    else
      @most_popular_web_pages = sorted_log_entries
      @cache_valid = true
      @most_popular_web_pages
    end
  end

  private

  def sorted_log_entries
    log_entries_with_website_visits.sort { |a, b| b[1] <=> a[1] }
  end

  def log_entries_with_website_visits
    grouped_log_entries.map { |web_address, ip_addresses| [web_address, ip_addresses.count] }
  end

  def grouped_log_entries
    @all.group_by { |web_log_entry| web_log_entry.page_address }
  end
end