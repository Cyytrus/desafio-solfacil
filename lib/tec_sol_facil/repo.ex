defmodule TecSolFacil.Repo do
  use Ecto.Repo,
    otp_app: :tec_sol_facil,
    adapter: Ecto.Adapters.Postgres
end
