class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service请求
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # 核实用户是否正确
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # 不正确时提示错误
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end