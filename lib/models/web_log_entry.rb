require 'active_model'
require 'ipaddress'

class WebLogEntry
  include ActiveModel::Validations

  attr_accessor :page_address, :ip_address

  validates :page_address, presence: true
  validates :ip_address, presence: true

  validate :valid_page_address_format
  validate :valid_ip_address_format


  def initialize(page_address: nil, ip_address: nil)
    @page_address = page_address
    @ip_address = remove_zeros_from_ip(ip_address)
  end

  def valid_page_address_format
    unless page_address.is_a?(String) && !page_address.strip.empty? && page_address[0] == '/'
      errors.add(:page_address, 'page_address needs to start with /')
    end
  end

  def valid_ip_address_format
    unless ip_address.is_a?(String) && !page_address.strip.empty?
      errors.add(:ip_address, 'ip_address needs to be a non empty string')
    end

    unless IPAddress.valid?(ip_address)
      errors.add(:ip_address, 'ip_address needs to be a valid IP Address')
    end
  end

  private

  def remove_zeros_from_ip(ip_add)
    address_array = ip_add.split('.').map do |element|
      if element.length == 1
        element
      elsif element[0] == '0'
        element.slice!(0)
        element
      else
        element
      end
    end

    address_array.join('.')
  end
end