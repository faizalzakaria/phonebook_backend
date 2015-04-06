require 'spec_helper'

describe Backend::API do

  include Rack::Test::Methods

  def app
    Backend::API
  end

  describe 'Test contact' do

    it 'should format download data correctly' do
      Contact.create(name: 'abc', phone: '123')
      Contact.create(name: 'abcd', phone: '1234')
      -> { Contact.format_download_data }.should_not raise_error
    end
  end

end
