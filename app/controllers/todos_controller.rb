class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    # 获取当前登陆用户的todos
    @todos = current_user.todos
    json_response(@todos)
  end

  def show
    json_response(@todo)
  end

  def create
    # 提交的todos属于当前用户的
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :crated)
  end

  def update
    @todo.update(todo_parmas)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
