module Backend
  class Contacts < Grape::API
    version 'v1', using: :header, vendor: 'fainow'

    rescue_from :all

    get '/public/*' do
    end

    resource :contacts do

      post '/upload' do
        Contact.upload(params.delete(:contacts))
      end

      get '/download' do
        Contact.download
        content_type "application/octet-stream"
        header['Content-Disposition'] = "attachment; filename=download.txt"
        env['api.format'] = :binary
        File.open('public/download.txt').read
      end

      # show all
      get do
        Contact.all
      end

      # Create
      post do
        Contact.create(params)
      end

      # Show
      route_param :id do
        get do
          Contact.find(params[:id])
        end

        # Update
        put do
          contact = Contact.find(params[:id])
          fail 'No found book found' unless contact
          contact.update_attributes(params.delete(:contact))
          contact
        end

        # Delete
        delete do
          contact = Contact.find(params[:id])
          fail 'No found book found' unless contact
          contact.delete
        end

      end # Route_param
    end # Resource contacts

  end
end
