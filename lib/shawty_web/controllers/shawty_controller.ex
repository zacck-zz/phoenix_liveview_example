defmodule ShawtyWeb.ShawtyController do
  use ShawtyWeb, :controller
  import Phoenix.LiveView.Controller
  alias Shawty.Cache
  alias ShawtyWeb.ShawtyLive


  def show(conn, %{"id" => slug}) do
    with {:ok, link} <- Cache.get(slug) do
      redirect(conn, external: link)
    else
     _ -> text(conn, "Sorry Url does not exist or is expired")
    end
  end
end
