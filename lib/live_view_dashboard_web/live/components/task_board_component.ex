defmodule LiveViewDashboardWeb.Components.TaskBoardComponent do
  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-gray-900">Task Board</h2>
      </div>

      <div class="grid grid-cols-3 gap-4">
        <%= for {status, tasks} <- @tasks do %>
          <div>
            <div class="flex items-center justify-between mb-3">
              <h3 class="text-lg font-semibold text-gray-700">
                <%= status |> to_string() |> String.replace("_", " ") |> String.capitalize() %>
              </h3>
              <span class="bg-gray-100 text-gray-600 px-2 py-1 rounded-full text-sm">
                <%= length(tasks) %>
              </span>
            </div>

            <div
              class="bg-gray-50 rounded-lg p-3 min-h-[150px]"
              id={"column-#{status}"}
              phx-hook="TaskColumn"
              data-status={status}
            >
              <%= for task <- tasks do %>
                <div
                  class="bg-white rounded mb-2 p-3 shadow-sm hover:shadow-md transition-shadow duration-200 cursor-move"
                  id={"task-#{task.id}"}
                  phx-hook="TaskItem"
                  data-task-id={task.id}
                  draggable="true"
                >
                  <div class="text-sm font-medium text-gray-900"><%= task.title %></div>
                </div>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, tasks: assigns.tasks)}
  end

  @impl true
  def mount(socket) do
    {:ok, socket}
  end
end
