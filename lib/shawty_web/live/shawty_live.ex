defmodule ShawtyWeb.ShawtyLive do
  use ShawtyWeb, :live_view

  def mount(_, _, socket) do
    {:ok, assign(socket, url_error: "", validated: false)}
  end

  def handle_event("validate", %{"url" => %{"value" => v}}, socket) do
    if validator(v) do
      {:noreply, assign(socket, url_error: "", validated: true)}
    else
      {:noreply, assign_error(socket)}
    end
  end

  def handle_event("shorten", %{"url" => %{"value" => url}}, %{assigns: %{validated: v}} = socket) do
    if v do
      _hash =
        Hashids.new(salt: url)
        |> Hashids.encode([1,2,3])
        |> IO.inspect()
      {:noreply, socket}
    else
      {:noreply, assign_error(socket)}
    end
  end

  defp validator(url) do
    uri = URI.parse(url)
    uri.scheme != nil && uri.host =~ "."
  end

  defp assign_error(socket) do
    assign(socket, url_error: "Please input a valid url for shawtening")
  end

end
