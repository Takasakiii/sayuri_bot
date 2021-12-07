defmodule Sayuri.Modules.Consumer do
  require Logger
  use Nostrum.Consumer

  alias Sayuri.Commands
  alias Sayuri.Modules.HandleForms

  def start_link, do: Consumer.start_link(__MODULE__)

  def handle_event({:READY, _data, _ws_stare}) do
    Task.Supervisor.start_child(
      Sayuri.TaskSupervisor,
      fn ->
        Sayuri.Modules.Status.status_task()
      end,
      restart: :transient
    )

    case Nosedrum.Interactor.Dispatcher.add_command(
           "echo",
           Commands.Echo,
           :global
         ) do
      {:ok, _} -> Logger.log(:info, "Registered Echo command.")
      e -> Logger.log(:error, "Failed to register Echo command: #{e}")
    end

    case Nosedrum.Interactor.Dispatcher.add_command("counter", Commands.Counter, :global) do
      {:ok, _} -> Logger.log(:info, "Registered Counter command.")
      e -> Logger.log(:error, "Failed to register Counter command: #{e}")
    end
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    if interaction.type == 2 do
      Nosedrum.Interactor.Dispatcher.handle_interaction(interaction)
    else
      id = interaction.data.custom_id

      unless !id do
        HandleForms.call(id, interaction)
        Sayuri.Modules.HandleFormsEts.call_form(id, interaction)
      end
    end
  end

  def handle_event({status, _data, _ws}) do
    Logger.log(:warning, "Evento não tratado: #{inspect(status)}")
  end
end
