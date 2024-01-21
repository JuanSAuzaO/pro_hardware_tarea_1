class ApplicationController < ActionController::API
  before_action :auth_middleware

  def auth_middleware
    devise_paths = ['/api/v1/signup', '/api/v1/login', '/api/v1/logout']
    if request.headers['Authorization']
      jwt_payload = payload(request.headers['Authorization'])
      user = User.find(jwt_payload['sub'])
    end
    render json: { error: 'Unauthorized action, please sign up or sign in first' }, status: :unauthorized unless
    cleared?(user, jwt_payload, devise_paths)
  end

  def cleared?(user, jwt_payload, devise_paths)
    user && jwt_payload['jti'] == user.jti || devise_paths.any? { |path| request.fullpath.include?(path) }
  end

  def payload(header)
    JWT.decode(header.split(' ').last,
               Rails.application.credentials.devise_jwt_secret_key!).first
  end
end
