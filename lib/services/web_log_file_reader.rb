class WebLogFileReader
  attr_accessor :log_lines, :filepath

  def initialize(filepath)
    raise ArgumentError.new('Please provide a valid file path')  unless File.file?(filepath)
    @log_lines = []
    @filepath = filepath
  end

  def execute
    File.readlines(@filepath).each do |line|
      page_address, ip_address = line.split
      @log_lines << { page_address: page_address, ip_address: ip_address }
    end
  end
end