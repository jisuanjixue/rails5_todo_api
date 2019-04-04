class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  #检查版本是默认的还是指定的
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  def check_headers(headers)
    # 从头部检查版本， 希望指定的是todos
    accept = headers[:accept]
    accept && accept.include?("application/vnd.todos.#{version}+json")
  end
end