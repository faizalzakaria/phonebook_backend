module Backend
  class PhoneBooks < Grape::API
    version 'v1', using: :header, vendor: 'fainow'

    rescue_from :all

    get '/public/*' do
    end

    resource :phone_books do

      post '/upload' do
        PhoneBook.upload(params.delete(:phone_books))
      end

      get '/download' do
        PhoneBook.download
        content_type "application/octet-stream"
        header['Content-Disposition'] = "attachment; filename=download.txt"
        env['api.format'] = :binary
        File.open('public/download.txt').read
      end

      # show all
      get do
        params.delete(:route_info)
        JSON.parse PhoneBook.fastapi.filter(params).response
      end

      # Create
      post do
        PhoneBook.create(params)
      end

      # Show
      route_param :id do
        get do
          JSON.parse PhoneBook.fastapi.fetch(params[:id]).response
        end

        # Update
        put do
          phone_book = PhoneBook.find(params[:id])
          fail 'No found book found' unless phone_book
          phone_book.update_attributes(params.delete(:phone_book))
          phone_book
        end

        # Delete
        delete do
          phone_book = PhoneBook.find(params[:id])
          fail 'No found book found' unless phone_book
          phone_book.delete
        end

      end # Route_param
    end # Resource phone_books

  end
end
