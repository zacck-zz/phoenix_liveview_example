defmodule ShawtyWeb.ShawtyLive do
  use ShawtyWeb, :live_view
  alias Shawty.Cache

  def mount(_params, _, socket) do
    {:ok, assign(socket, error: "", validated: false, result: "")}
  end

  def handle_event("validate", %{"url" => %{"value" => v}}, socket) do
    if validator(v) do
      {:noreply, assign(socket, error: "", validated: true)}
    else
      {:noreply, assign_error(socket)}
    end
  end

  def handle_event("shorten", %{"url" => %{"value" => url}}, %{assigns: %{validated: v}} = socket) do
    with true <- v,
         {:ok, {slug, _}} <- store_url(url)
    do
      link = ShawtyWeb.Endpoint.url() <> "/go/" <> slug
      {:noreply, assign(socket, result: link)}
    else
      false -> (assign_error(socket))
      _ -> assign(socket, error: "An error occured while storing your link please try again later")
    end
  end

  defp store_url(url) do
    Hashids.new(salt: url)
    |> Hashids.encode([1,2,3])
    |> Cache.put(url)
  end

  defp validator(url) do
    uri = URI.parse(url)
    uri.scheme != nil && uri.host =~ "."
  end

  defp assign_error(socket) do
    assign(socket, error: "Please input a valid url for shawtening")
  end

end
