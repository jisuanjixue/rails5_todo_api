require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # 登陆测试
  describe 'POST /auth/login' do
    # 创建用户
    let!(:user) { create(:user) }
    # 授权头部
    let(:headers) { valid_headers.except('Authorization') }
    #测试有效与无效用户
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # 当请求有效时返回真实的token
    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # 当请求无效时返回错误信息
    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end
end