require 'active_support/concern'
require 'active_model/validator'
require 'active_model/validations'
require 'active_model/naming'
require 'active_model/callbacks'
require 'active_support/callbacks'
require 'active_model/translation'
require 'active_model'

class WebLogEntry
  include ActiveModel::Validations

  attr_accessor :page_address, :ip_address

  validates :page_address, presence: true
  validates :ip_address, presence: true

  def initialize(page_address: nil, ip_address: nil)
    @page_address = page_address
    @ip_address = ip_address
  end
end