class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # 应用在用户请求之前必须登陆
  before_action :authorize_request
  attr_reader :current_user

  private

  # 用户登陆检查token是否有效
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

end
