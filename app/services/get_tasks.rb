class GetTasks
  def initialize(user, show_closed_tasks = false)
    @user = user
    @show_closed_tasks = show_closed_tasks
  end

  def execute
    return [] if @user.blank?
    state = ["opened", "in_progress"]
    state.push("closed") if @show_closed_tasks

    @user.tasks.where(state: state)
  end
end