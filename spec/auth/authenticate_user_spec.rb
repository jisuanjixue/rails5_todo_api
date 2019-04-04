require 'rails_helper'

RSpec.describe AuthenticateUser do
  # 创建测试用户
  let(:user) { create(:user) }
  # 有效的用户信息
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # 无效用户信息
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

    #call的类里是测试请求的方法
  describe '#call' do
    # 返回token，当有效时
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # 返回错误信息当无效时
    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end