defmodule Sayuri.Modules.HandleForms do
  use GenServer

  def init(_state), do: {:ok, []}

  def handle_cast({:stack, id, call}, state) do
    if is_binary(id) do
      {:noreply, [{id, call} | state]}
    else
      {:noreply, [{Integer.to_string(id), call} | state]}
    end
  end

  def handle_cast({:call, id, interaction}, state) do
    item = Enum.find(state, nil, fn {id_p, _} -> id == id_p end)

    if item do
      {id, call} = item
      new_state = Enum.filter(state, fn {id_p, _} -> id != id_p end)
      call.(interaction)
      {:noreply, new_state}
    else
      {:noreply, state}
    end
  end

  ## Public API
  def start_link(_args), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  def handle(id, call), do: GenServer.cast(__MODULE__, {:stack, id, call})
  def call(id, interaction), do: GenServer.cast(__MODULE__, {:call, id, interaction})
end
