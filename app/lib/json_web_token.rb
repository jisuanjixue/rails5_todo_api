class JsonWebToken
  # 安全的解码和编码token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # 设置24小时后过期失效
    payload[:exp] = exp.to_i
    # 安全的注册token
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # 获取参数，数组的第一项
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
    # 修复 编码的出错
  rescue JWT::DecodeError => e
    # 出错信息的绑定
    raise ExceptionHandler::InvalidToken, e.message
  end
end