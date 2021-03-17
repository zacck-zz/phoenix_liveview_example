defmodule ShawtyWeb.ShawtyLiveTest do
  use ShawtyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, shawty_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Shawt Urls"
    assert render(shawty_live) =~ "Shorten"
  end
end
