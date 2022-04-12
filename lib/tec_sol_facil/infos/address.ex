defmodule TecSolFacil.Infos.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :bairro, :string
    field :cep, :string
    field :ddd, :string
    field :ibge, :string
    field :localidade, :string
    field :logradouro, :string
    field :uf, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:logradouro, :cep, :bairro, :localidade, :uf, :ibge, :ddd])
    |> validate_required([:logradouro, :cep, :bairro, :localidade, :uf, :ibge, :ddd])
  end
end
