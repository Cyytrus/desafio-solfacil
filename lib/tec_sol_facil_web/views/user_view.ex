defmodule TecSolFacilWeb.UserView do
  use TecSolFacilWeb, :view
  alias TecSolFacilWeb.UserView

  def render("index.json", %{email: email}) do
    %{data: render_many(email, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      password: user.password
    }
  end
end
