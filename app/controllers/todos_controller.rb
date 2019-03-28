class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all
    json_response(@todos)
  end

  def show
    json_response(@todo)
  end

  def create
    @todo = Todo.create!(todo_params)
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
    parmas.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
