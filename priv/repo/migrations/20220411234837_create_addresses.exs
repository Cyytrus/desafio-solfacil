defmodule TecSolFacil.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :logradouro, :string
      add :cep, :string
      add :bairro, :string
      add :localidade, :string
      add :uf, :string
      add :ibge, :string
      add :ddd, :string

      timestamps()
    end
  end
end
