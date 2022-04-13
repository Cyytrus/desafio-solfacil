defmodule TecSolFacil.API.CEP.CepConsult do
  use Tesla

  @useful_data [:logradouro, :cep, :bairro, :localidade, :uf, :ibge, :ddd]

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"

  def get_user_address_info(cep) do
    get("/#{cep}/json")
    |> handle_response()
  end

  defp handle_response({:ok, %{body: content}}) do
    content
    |> Jason.decode!()
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.filter(fn {k, _v} -> k in @useful_data end)
  end

  defp handle_response({:error, reason}), do: reason
end
