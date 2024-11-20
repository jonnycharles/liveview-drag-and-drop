defmodule LiveViewDashboard.Repo do
  use Ecto.Repo,
    otp_app: :live_view_dashboard,
    adapter: Ecto.Adapters.Postgres
end
