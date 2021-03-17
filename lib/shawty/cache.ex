defmodule Shawty.Cache do
  @moduledoc """
  Implementation for a cache to store the shortened Url, it is
  Volatile at the moment but could easily be converted to non volatile
  or other methods used
  """

  @name :cache
  @cache_table :cache_table

  use GenServer

  ## Client

  @doc """
  Starts the cache
  """
  @spec start_link(term()) :: {:ok, term()} | {:error, term()}
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end


  @doc """
  Places a new url in the cache keyed by a generated  unique hash
  """
  @spec put(String.t(), String.t()) :: {:ok, String.t()} | {:error, term()}
  def put(hash, url) do
    GenServer.call(@name, {:put, {hash, url}})
  end


  @doc """
  Gets a stored url using the hash if non exists returns an error tuple
  """
  @spec get(String.t()) :: {:ok, String.t()} | {:error, atom()}
  def get(hash) do
    case :ets.lookup(@cache_table, hash) do
      [{^hash, value}] -> {:ok, value}
      [] -> {:error, :does_not_exist}
    end
  end


  ## Server

  @doc """
  Initialize cache by starting an ETS table

  Parameters - are ignored for now
  """
  @spec init(term()) ::{:ok, term()}
  def init(_) do
    state = %{
      cache_table: :ets.new(@cache_table, [:named_table])
    }

    {:ok, state}
  end

  @doc """
  Callback to handle putting data into the cache
  """
  @spec handle_call(tuple(), pid(), map()) ::{:ok, term()} | {:error, term()}
  def handle_call({:put, item}, _from, %{cache_table: table} = state)  do
    result =
      case :ets.insert(table, item) do
        true -> {:ok, item}
        err -> {:error, err}
      end

    {:reply, result, state}
  end
end
