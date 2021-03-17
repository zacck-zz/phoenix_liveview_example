defmodule ShawtyWeb.ShawtyLive do
  use ShawtyWeb, :live_view

  def mount(_, _, socket) do
    {:ok, assign(socket, url_error: "")}
  end

  def handle_event("validate", %{"url" => %{"value" => v }}, socket) do
    if validator(v) do
      {:noreply, assign(socket, url_error: "")}
    else
      {:noreply, assign(socket, url_error: "Please input a valid url for shawtening")}
    end
  end

  def handle_event("shorten", input, socket) do
    IO.inspect(input)
    _hash =
      Hashids.new(salt: to_string(:os.system_time(:millisecond)))
      |> Hashids.encode([1,2,3])
      |> IO.inspect()
    {:noreply, socket}
  end

  defp validator(url) do
    uri = URI.parse(url)
    uri.scheme != nil && uri.host =~ "."
  end

end
