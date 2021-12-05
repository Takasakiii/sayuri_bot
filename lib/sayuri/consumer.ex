defmodule Sayuri.Consumer do
  require Logger
  use Nostrum.Consumer

  def start_link, do: Consumer.start_link(__MODULE__)

  def handle_event({:READY, _data, _ws_stare}) do
    case Nosedrum.Interactor.Dispatcher.add_command(
           "echo",
           Sayuri.Commands.Echo,
           :global
         ) do
      {:ok, _} -> IO.puts("Registered Echo command.")
      e -> IO.inspect(e, label: "An error occurred registering the Echo command")
    end
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    Nosedrum.Interactor.Dispatcher.handle_interaction(interaction)
  end

  def handle_event(event) do
    Logger.log(:warning, "Evento não tratado: #{inspect(event)}")
  end
end
