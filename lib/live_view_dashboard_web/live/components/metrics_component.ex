defmodule LiveViewDashboardWeb.Components.MetricsComponent do
  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <h2 class="text-2xl font-semibold text-gray-900">Metrics Overview</h2>
        <div class="flex items-center space-x-4">
          <div class="flex items-center">
            <div class="h-3 w-3 rounded-full bg-blue-500 mr-2"></div>
            <span class="text-sm text-gray-600">Completion Rate</span>
          </div>
          <div class="flex items-center">
            <div class="h-3 w-3 rounded-full bg-green-500 mr-2"></div>
            <span class="text-sm text-gray-600">Tasks</span>
          </div>
        </div>
      </div>

      <div class="relative">
        <canvas
          id="metrics-chart"
          phx-hook="MetricsChart"
          data-metrics={Jason.encode!(@metrics)}
          class="rounded-lg"
          width="600"
          height="300"
        >
        </canvas>
      </div>
    </div>
    """
  end

end
