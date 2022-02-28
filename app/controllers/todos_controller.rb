class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy change_status ]

  def index
    @status = params[:status].presence || 'incomplete'
    @todos = Todo.where(status: @status )
  end

  def show; end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        flash.now[:notice] = "Todo was successfully created."
        format.turbo_stream
        format.html { redirect_to root_url, notice: "Todo was successfully created." }
      else
        flash.now[:alert] = @todo.errors.full_messages.join('; ')
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        flash.now[:notice] = "Todo was successfully updated."
        format.turbo_stream
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully updated." }
      else
        flash.now[:alert] = @todo.errors.full_messages.join('; ')
        format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |format|
      flash.now[:notice] = "Todo was successfully destroyed."
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@todo)}_container") }
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
    end
  end

  def change_status
    @todo.update(status: todo_params[:status])

    respond_to do |format|
      flash.now[:notice] = "Updated todo status."
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@todo)}_container") }
      format.html { redirect_to todos_path, notice: "Updated todo status." }
    end
  end

  private

    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:name, :status)
    end
end
