require 'spec_helper'

describe Backend::API do

  include Rack::Test::Methods

  def app
    Backend::API
  end

  describe 'Test phone api' do

    let(:contact) do
      {
        name: "Jumbo Mumbo",
        phone: "619 788 3983"
      }
    end

    it 'should create phone book' do
      post '/api/v1/contacts', contact
      assert_response_success last_response
    end

    it 'should return all phone book' do
      post '/api/v1/contacts', contact
      assert_response_success last_response
      post '/api/v1/contacts', contact
      assert_response_success last_response
      post '/api/v1/contacts', contact
      assert_response_success last_response
      get '/api/v1/contacts'
      assert_response_success last_response
      JSON.parse(last_response.body).count.should eq(3)
    end

    it 'should get 1 phone book' do
      post '/api/v1/contacts', contact
      assert_response_success last_response
      contact = JSON.parse last_response.body
      get "/api/v1/contacts/#{contact['id']}"
      assert_response_success last_response
      JSON.parse(last_response.body).count.should eq(1)
    end

    it 'should update a phone book' do
      post '/api/v1/contacts', contact
      assert_response_success last_response
      parsed_data = JSON.parse last_response.body
      parsed_data = parsed_data['contact']
      put "/api/v1/contacts/#{parsed_data['id']}", { name: 'Tata Titi' }
      assert_response_success last_response
    end

    it 'should delete a phone book' do
      post '/api/v1/contacts', contact
      assert_response_success last_response
      parsed_data = JSON.parse last_response.body
      parsed_data = parsed_data['contact']
      delete "/api/v1/contacts/#{parsed_data['id']}"
      assert_response_success last_response
    end

    it 'should upload a phone book' do
      Contact.count.should eq(0)
      Contact.create(name: 'Destinee Hilll', phone: '123456')
      Contact.count.should eq(1)
      post '/api/v1/contacts/upload', { contacts: mock_upload_data }
      assert_response_success last_response
      Contact.count.should eq(4)
    end

  end

  def mock_upload_data
    "Ms. Evelyn Tillman    771-601-2068\n" \
    "Sedrick McClure    1-157-268-7790 x9877\n" \
    "Monty Walter    229-224-8794\n" \
    "Destinee Hilll    384.988.9962 x164\n" \
  end

  def assert_response_success(response)
    [201, 200].include?(response.status).should == true
  end

  def assert_response_failed(response)
    [404, 500].include?(response.status).should == true
  end

end
