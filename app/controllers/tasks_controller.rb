class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = GetTasks.new(current_user, params[:show_closed_tasks] === "true").execute
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url }
      else
        format.html { redirect_to tasks_url, alert: @task.errors.first.full_message }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated." }
      else
        format.html { redirect_to tasks_url, notice: "Faild to update the task." }
      end
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.remove!
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:is_urgent, :is_important, :description, :user_id, :state)
  end
end
