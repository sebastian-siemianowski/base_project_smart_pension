# frozen_string_literal: true

require 'spec_helper'
require 'services/web_log_parser'

RSpec.describe WebLogParser do
  subject { described_class.new('spec/fixtures/webserver_test.log') }

  describe 'when testing formatted web page count' do
    let(:correct_output_for_webserver_test_log) { ['/help_page/1 7 visits', '/contact 3 visits', '/home 3 visits', '/about/2 2 visits', '/index 1 visits', '/about 1 visits'] }
    it 'gives test output to test the project health' do
      expect(subject.formatted_web_page_count).to eq correct_output_for_webserver_test_log
    end

    describe 'when testing malformed web address' do
      subject { described_class.new('spec/fixtures/webserver_test_malformed_url.log') }
      let(:correct_output_for_webserver_test_log) { ['/help_page/1 7 visits', '/home 3 visits', '/contact 2 visits', '/about/2 2 visits', '/index 1 visits', '/about 1 visits'] }
      it 'omits entries that are malformed' do
        expect(subject.formatted_web_page_count).to eq correct_output_for_webserver_test_log
      end
    end
  end

  describe 'when testing formatted web page unique count' do
    let(:correct_output_for_webserver_test_log) { ['/help_page/1 5 unique visits', '/home 3 unique visits', '/contact 2 unique visits', '/about/2 1 unique visits', '/index 1 unique visits', '/about 1 unique visits'] }

    it 'gives test output to test the project health' do
      expect(subject.formatted_web_page_unique_count).to eq correct_output_for_webserver_test_log
    end

    describe 'when testing malformed api address' do
      subject { described_class.new('spec/fixtures/webserver_test_malformed_api_address.log') }
      let(:correct_output_for_webserver_test_log) { ['/help_page/1 5 unique visits', '/home 3 unique visits', '/contact 1 unique visits', '/about/2 1 unique visits', '/index 1 unique visits', '/about 1 unique visits'] }
      it 'omits entries that are malformed' do
        expect(subject.formatted_web_page_unique_count).to eq correct_output_for_webserver_test_log
      end
    end
  end
end
