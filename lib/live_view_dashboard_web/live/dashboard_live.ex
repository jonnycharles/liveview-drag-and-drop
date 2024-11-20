defmodule LiveViewDashboardWeb.DashboardLive do
  use LiveViewDashboardWeb, :live_view
  alias LiveViewDashboardWeb.Components.{TaskBoardComponent, MetricsComponent}

  @impl true
  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, any()}
  def mount(_params, _session, socket) do
    if connected?(socket), do: schedule_metrics_update()

    {:ok, assign(socket,
     tasks: initial_tasks(),
     metrics: fetch_metrics())}
  end

  @impl true
  def handle_event("move_task", %{"task_id" => id, "to" => column}, socket) do
    {:noreply, update(socket, :tasks, &move_task(&1, id, column))}
  end

  @impl true
  def handle_info(:update_metrics, socket) do
    schedule_metrics_update()
    {:noreply, update(socket, :metrics, &update_metrics/1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-gray-50 py-8 w-full">
      <div class="px-4 sm:px-6 lg:px-8 w-full">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 w-full">
          <!-- Metrics Card -->
          <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="p-6">
              <.live_component module={MetricsComponent} id="metrics" metrics={@metrics} />
            </div>
          </div>

          <!-- Task Board Card -->
          <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="p-6">
              <.live_component module={TaskBoardComponent} id="tasks" tasks={@tasks} />
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end


  defp schedule_metrics_update, do: Process.send_after(self(), :update_metrics, 5000)

  defp initial_tasks do
    %{
      "todo" => [%{id: "1", title: "Design UI"}, %{id: "2", title: "Write tests"}],
      "in_progress" => [%{id: "3", title: "Implement API"}],
      "done" => [%{id: "4", title: "Setup project"}]
    }
  end

  defp fetch_metrics do
    [
      %{date: "2024-01", tasks: 5, completion: 80},
      %{date: "2024-02", tasks: 8, completion: 75},
      %{date: "2024-03", tasks: 6, completion: 90}
    ]
  end

  defp move_task(tasks, task_id, to_column) do
    task = Enum.find_value(tasks, fn {_, tasks} ->
      Enum.find(tasks, & &1.id == task_id)
    end)

    tasks
    |> Enum.map(fn {col, tasks} ->
      {col, tasks |> Enum.reject(& &1.id == task_id)}
    end)
    |> Map.new()
    |> Map.update!(to_column, &[task | &1])
  end

  defp update_metrics(metrics) do
    [%{
      date: DateTime.utc_now() |> Calendar.strftime("%H:%M"),
      tasks: :rand.uniform(10),
      completion: :rand.uniform(100)
    } | Enum.take(metrics, 5)]
  end
end
