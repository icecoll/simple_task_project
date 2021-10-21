module TasksHelper
  def state_change_button(task)
    return if task.closed? || task.removed?

    if task.opened?
      button_name = "start"
      button_class = "btn-outline-secondary"
      state = "in_progress"
    elsif task.in_progress?
      button_name = "done"
      button_class = "btn-primary"
      state = "closed"
    end

    button_to(
      button_name, task,
      method: :patch,
      class: "btn btn-sm #{button_class}",
      form_class: "text-center",
      data: {confirm: t("action_confirmation")},
      params: {task: {state: state}}
    )
  end

  def get_state_button_class(task)
    return "btn-primary" if task.opened?
    return "btn-success" if task.in_progress?
    return "btn-secondary" if task.closed?
  end
end
