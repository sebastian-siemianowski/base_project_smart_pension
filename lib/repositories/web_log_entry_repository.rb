class WebLogEntryRepository
  attr_reader :all, :non_unique_cache_valid, :unique_cache_valid

  def initialize
    @all         = []
    @cache_valid = true
  end

  def add(web_log_entry)
    return unless web_log_entry.is_a?(WebLogEntry) && web_log_entry.valid?

    @all << web_log_entry
    @non_unique_cache_valid = false
    @unique_cache_valid     = false
  end

  def most_popular_web_pages
    return @most_popular_web_pages if @most_popular_web_pages && @non_unique_cache_valid

    @most_popular_web_pages = sorted_log_entries
    @non_unique_cache_valid = true
    @most_popular_web_pages
  end

  def most_popular_unique_pages
    return @most_popular_unique_web_pages if @most_popular_unique_web_pages && @cache_valid

    @most_popular_unique_web_pages = sorted_log_entries(unique: true)
    @cache_valid                   = true
    @most_popular_unique_web_pages
  end

  private

  def sorted_log_entries(unique: false)
    log_entries_with_website_visits(unique: unique).sort { |a, b| b[1] <=> a[1] }
  end

  def log_entries_with_website_visits(unique: false)
    if unique
      grouped_log_entries.map do |web_address, ip_addresses|
        unique_addresses = ip_addresses.map(&:ip_address).uniq
        [web_address, unique_addresses.count]
      end
    else
      grouped_log_entries.map { |web_address, ip_addresses| [web_address, ip_addresses.count] }
    end
  end

  def grouped_log_entries
    @all.group_by(&:page_address)
  end
end