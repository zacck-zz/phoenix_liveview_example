defmodule ShawtyWeb.ShawtyControllerTest do
  use ShawtyWeb.ConnCase

  alias Shawty.Cache

  describe "show" do
    test "shows an error when link is not found", %{conn: conn} do
      conn = get conn, "/go/some_id"

      assert text_response(conn, 200) =~ "Url does not exist"
    end


    test "redirects to url when link is found", %{conn: conn} do
      link = "http://google.com"
      hash = "some_hash"
      Cache.put(hash, link)

      conn = get conn, ("/go/" <> hash)

      assert redirected_to(conn) =~ link
    end
  end
end
