defmodule Sayuri.Modules.HandleFormsEts do
  use GenServer

  def init(_status), do: :dets.open_file(:handle_forms_ets, type: :set)

  def handle_cast({:add, id, data, callback}, state) do
    :dets.insert(state, {id, {data, callback}})
    {:noreply, state}
  end

  def handle_cast({:call, id, it}, state) do
    item = :dets.lookup(state, id)

    case item do
      {:error, _} ->
        {:reply, :no_item, state}

      [head | _] ->
        {_, {data, callback}} = head
        callback.(it, data)
        {:noreply, state}
    end
  end

  def handle_cast({:delete, id}, state) do
    :dets.delete(state, id)
    {:noreply, state}
  end

  ## Public API

  def start_link(_args), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def add_form(id, data, callback) when is_binary(id),
    do: GenServer.cast(__MODULE__, {:add, id, data, callback})

  def call_form(id, it) when is_binary(id), do: GenServer.cast(__MODULE__, {:call, id, it})
  def delete_form(id) when is_binary(id), do: GenServer.cast(__MODULE__, {:delete, id})
end
