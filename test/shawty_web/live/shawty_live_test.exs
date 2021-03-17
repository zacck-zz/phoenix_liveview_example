defmodule ShawtyWeb.ShawtyLiveTest do
  use ShawtyWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, shawty_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Shawt Urls"
    assert render(shawty_live) =~ "Shorten"
  end

  test "displays error if button is pressed without input", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :shorten, %{"url" => %{"value" => ""}})  =~ "Please input a valid url"
  end

  test "displays error if a url is invalid", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :shorten, %{"url" => %{"value" => "http://bad"}}) =~ "Please input a valid url"
  end
end
