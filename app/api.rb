module Backend
  class API < Grape::API
    prefix 'api/v1'
    format :json

    mount Backend::HealthCheck
    mount Backend::PhoneBooks
  end
end
