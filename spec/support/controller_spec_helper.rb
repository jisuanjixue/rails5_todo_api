module ControllerSpecHelper
  # 用户生成tokens
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # 用户生成过期的tokens
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # 返回有效的头部
  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  # 返回无效的头部
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end
end