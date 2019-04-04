module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end


  included do
    # 422错误
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    # 用户授权请求错误
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    # token失效422错误
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    # 无效的token422错误
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    #找不到错误
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end