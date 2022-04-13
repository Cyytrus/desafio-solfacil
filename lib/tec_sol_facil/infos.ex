defmodule TecSolFacil.Infos do
  @moduledoc """
  The Infos context.
  """

  import Ecto.Query, warn: false
  alias TecSolFacil.Repo
  alias TecSolFacil.Infos.Address
  alias TecSolFacilWeb.Oban.Exporters.CsvExporter

  def list_addresses do
    Repo.all(Address)
  end

  def get_address(cep), do: Repo.get_by(Address, cep: cep)

  def create_address(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  def call_oban(%{}) do
    %{}
    |> CsvExporter.new()
    |> Oban.insert()
  end
end
