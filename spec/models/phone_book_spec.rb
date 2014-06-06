require 'spec_helper'

describe Backend::API do

  include Rack::Test::Methods

  def app
    Backend::API
  end

  describe 'Test phone book' do

    it 'should format download data correctly' do
      PhoneBook.create(name: 'abc', phone: '123')
      PhoneBook.create(name: 'abcd', phone: '1234')
      -> { PhoneBook.format_download_data }.should_not raise_error
    end
  end

end
