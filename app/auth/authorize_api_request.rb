class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # 请求服务器， 返回有效的用户
  def call
    {
      user: user
    }
  end

  private

  # 头部属性
  attr_reader :headers

  def user
    #检查用户是否在数据库里
    #记住用户
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # 找不到用户处理
    rescue ActiveRecord::RecordNotFound => e
      # 优先提示错误
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
  end

  # 破解验证Token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # 检查头部授权是否有Token
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end