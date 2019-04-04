require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  # 添加用户的todos
  let!(:todos) { create_list(:todo, 10) } 
  let(:todo_id) { todos.first.id } 
  # 授权头部
  let(:headers) { valid_headers }

  #GET /todos
  describe "GET /todos" do
    before { get '/todos', params: {}, headers: headers }
    it "returns todos" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  #GET /todos/:id
  describe "GET /todos/:id" do
    before { get "/todos/#{todos_id}", params: {}, headers: headers }
    context "when the record exists" do
      it "returns the todo" do
        expect(json).not_to be_empty  
        expect(json['id']).to eq(todo_id)  
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context "when the record does not exist" do
      let(:todo_id) { 100 }
      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end
      
      it "returns a not found message" do
        expect(response).to match(/Couldn't find Todo/)
      end
      
    end
    
  end

  # POST /todos
  describe "POST /todos" do
    let(:valid_attributes) do
      { title: 'xuexi', created_by: user.id.to_s }.to_json
    end
    context "when the request is valid" do
      before { post '/todos', params:valid_attributes, headers: headers }
      it "creates a todo" do
        expect(json('title')).to eq('xuexi')  
      end
      
      it "return status code 201" do
        expect(response).to have_http_status(201)  
      end
    end    
  end

  context 'when the request is invalid' do
    let(:invalid_attributes) { { title: nil }.to_json }
    before { post '/todos', params: valid_attributes, headers: headers }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(response.body)
        .to match(/错误信息: id不能为空/)
    end
  end

  # PUT /todos/:id
  describe "PUT /todos/:id" do
    let(valid_attributes) { { title: 'shopping' }.to_json }
    before { put "/todos/#{todo_id}", params: validates_attributes, headers: headers }
    it "updates the record" do
      expect(response.body).to  be_empty
    end
    
    it "returns status code 204" do
      expect(response).to  have_http_status(204)
    end
  end

  # DELETE /todos/:id
  describe "DELETE /todos/:id" do
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }
    it "return status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
