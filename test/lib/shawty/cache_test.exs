defmodule Shawty.CacheTest do
  use ExUnit.Case, async: false

  alias Shawty.Cache

  setup do
    Application.stop(:shawty)

    Process.sleep(4)

    :ok = Application.start(:shawty)
  end

  describe "Cache" do
    test "get return error tuple if the hash is not present" do
      hash = to_string(:os.system_time(:millisecond))
      {:error, :does_not_exist} = Cache.get(hash)
    end

    test "put adds a hash and get collects the associated hash", %{file: f} do
      hash = to_string(:os.system_time(:millisecond))

      {:ok, _} = Cache.put(hash, f)

      {:ok, ^f} = Cache.get(hash)
    end
  end
end
