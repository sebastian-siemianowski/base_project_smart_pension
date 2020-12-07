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
    @ip_address = ip_address
  end

  def valid_page_address_format
    unless page_address.is_a?(String) && !page_address.strip.empty?
      errors.add(:page_address, 'page_address needs to be a non empty string')
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
end