defmodule TecSolFacilWeb.AddressController do
  use TecSolFacilWeb, :controller

  alias TecSolFacil.API.CEP.CepConsult
  alias TecSolFacil.Infos
  alias TecSolFacil.Infos.Address

  action_fallback TecSolFacilWeb.FallbackController

  def index(conn, _params) do
    addresses = Infos.list_addresses()
    render(conn, "index.json", addresses: addresses)
  end

  def show(conn, %{"cep" => cep}) do
    parsed_cep = cep |> String.split_at(5) |> then(fn {v1, v2} -> v1 <> "-" <> v2 end)

    address = Infos.get_address(parsed_cep)

    case address do
      nil ->
        create(conn, %{"cep" => cep})

      address ->
        render(conn, "show.json", address: address)
    end
  end

  def create(conn, %{"cep" => cep}) do
    with {:ok, %Address{} = address} <- Infos.create_address(search_cep(cep)) do
      Infos.call_oban(%{})

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.address_path(conn, :show, address))
      |> render("show.json", address: address)
    end
  end

  defp search_cep(cep), do: CepConsult.get_user_address_info(cep)
end
