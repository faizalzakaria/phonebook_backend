module Backend
  class App
    def initialize
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any,
            :methods => [:get, :post, :delete, :put, :options]
          end
        end
        run Backend::App.new
      end.to_app
    end

    def call(env)
      Backend::API.call(env)
    end
  end

end
