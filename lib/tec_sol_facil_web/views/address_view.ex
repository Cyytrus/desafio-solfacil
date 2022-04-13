defmodule TecSolFacilWeb.AddressView do
  use TecSolFacilWeb, :view
  alias TecSolFacilWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      logradouro: address.logradouro,
      cep: address.cep,
      bairro: address.bairro,
      localidade: address.localidade,
      uf: address.uf,
      ibge: address.ibge,
      ddd: address.ddd
    }
  end
end
