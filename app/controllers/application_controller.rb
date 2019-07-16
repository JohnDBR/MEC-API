class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
  
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Exceptions::CurrentUserNotFound, with: :if_user_not_found
    rescue_from Exceptions::TokenExpired, with: :if_token_expired
  
    before_action :get_current_user
  
    #{Rails.application.config.action_controller.default_url_options[:host]}
    def self.default_url_options
      if Rails.env.production?
        {
          env: "prod",
          host: "mec-api.jfarellano.xyz", 
          protocol: "http",
          front_url: "https://",
          admin_url: "https://"
        }
      elsif Rails.env.test?  
        {
          env: "test",
          host: "", 
          protocol: "https",
          front_url: "https://",
          admin_url: "https://"
        }
      else 
        {
          env: "dev",
          host: "localhost:3000", 
          protocol: "http",
          front_url: "https://",
          admin_url: "https://"
        }
      end
    end
  
    protected
    def get_current_user
      set_user_by_token
      raise Exceptions::CurrentUserNotFound unless @current_user
    end
 
    def set_user_by_token
      @current_user = nil
      authenticate_with_http_token do |key, options|
        @token = Token.find_by(secret: key)
        expired = @token ? @token.expire_at.past? : false
        if expired
          @token.destroy 
          raise Exceptions::TokenExpired
        end
        @current_user = @token.user if @token
      end
      # request.headers.each do |key, options|
      #   pp key
      #   pp options
      # end
    end
  
    def permissions_error
      render json: {authorization: 'you dont have permissions!'}, status: :permissions_error
    end
  
    def render_ok(obj)
      render json: obj, status: :ok
    end
  
    def if_save_succeeds(obj, options={})
      if obj.save
        self.send(options[:call_after_save]) if options[:call_after_save]
        yield(obj) if block_given?
      else
        self.send(options[:call_if_error]) if options[:call_if_error]
        render json: {errors:obj.errors.messages}, status: options[:error_status] || :unprocessable_entity
      end
    end
  
    def save_and_render(obj, options={})
      if_save_succeeds(obj, options) do |object|
        render json: options[:call_on_render] ? self.send(options[:call_on_render]) : object, status: options[:succeed_status] || :ok
        self.send(options[:call_after_render]) if options[:call_after_render]
      end
    end
  
    def record_not_found(exception)
      render json: {record_not_found:exception.message}, status: :unprocessable_entity
    end
  
    def if_user_not_found
      render json: {authentication: 'user not found'}, status: :unprocessable_entity
    end
  
    def if_token_expired
      render json: {authentication: 'token has expired'}, status: :unprocessable_entity
    end
  
  end
  