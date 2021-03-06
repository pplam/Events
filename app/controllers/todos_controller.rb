class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy, :assign_executor, :finish, :update_deadline]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
    @project = Project.find(params[:project_id]) if params[:project_id]
    @back_url = session[:previous_url] || @project
  end

  # GET /todos/1/edit
  def edit
    @project = @todo.project
    @back_url = session[:previous_url] || @todo
  end

  # PUT /todos/1/assign_executor
  def assign_executor
    pre_value = @todo.dup

    @todo.update_attribute(:executor_id, params[:executor_id])

    if @todo.executor_id != pre_value.executor_id
      event = @todo.target_events.build(content: 'reset executor for todo', target_field: 'content', resultable_type: 'User', resultable_id: params[:executor_id], result_field: 'name')
      event.user = current_user
      event.save
    end

    redirect_back fallback_location: @todo.project
  end

  # PUT /todos/1/finish
  def finish
    pre_value = @todo.dup

    @todo.update_attribute(:status, :finished)

    if @todo.status !=pre_value.status
      event = @todo.target_events.build(content: 'finish todo', target_field: 'content')
      event.user = current_user
      event.save
    end

    redirect_back fallback_location: @todo.project
  end

  # PUT /todos/1/update_deadline
  def update_deadline
    pre_value = @todo.dup

    @todo.update_attribute(:deadline, "#{params['deadline(1i)']}-#{params['deadline(2i)']}-#{params['deadline(3i)']}")

    if @todo.reload.deadline != pre_value.deadline
      event = @todo.target_events.build(content: 'update deadline for todo', target_field: 'content', resultable_type: 'Todo', resultable_id: @todo.id, result_field: 'deadline')
      event.user = current_user
      event.save
    end

    redirect_back fallback_location: @todo
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        event = @todo.target_events.build(content: 'created todo', target_field: 'content')
        event.user = current_user
        event.save

        if @todo.executor_id
          event = @todo.target_events.build(content: 'assign executor for todo', target_field: 'content', resultable_type: 'User', resultable_id: @todo.executor_id, result_field: 'name')
          event.user = current_user
          event.save
        end


        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      pre_value = @todo.dup
      if @todo.update(todo_params)
        if @todo.deadline != pre_value.deadline
          event = @todo.target_events.build(content: 'update deadline for todo', target_field: 'content', resultable_type: 'Todo', resultable_id: @todo.id, result_field: 'deadline')
          event.user = current_user
          event.save
        end

        if @todo.executor_id != pre_value.executor_id
          event = @todo.target_events.build(content: 'reset executor for todo', target_field: 'content', resultable_type: 'User', resultable_id: params[:executor_id], result_field: 'name')
          event.user = current_user
          event.save
        end

        format.html { redirect_back fallback_location: @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    project = @todo.project
    @todo.destroy
    @event = @todo.target_events.build(content: 'deleted todo', target_field: 'content')
    @event.user = current_user
    @err = @event.errors.messages
    byebug
    @event.save
    respond_to do |format|
      format.html { redirect_to project, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:content, :deadline, :status, :project_id, :creator_id, :executor_id)
    end
end
