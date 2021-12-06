defmodule Sayuri.Commands.Echo do
  @behaviour Nosedrum.ApplicationCommand

  alias Sayuri.Modules.HandleForms
  alias Nostrum.Api

  @impl true
  def description, do: "Echos a message grande dia"

  @impl true
  def command(interaction) do
    [%{name: "message", value: message}] = interaction.data.options
    id = interaction.id

    call = fn it ->
      Api.create_interaction_response(it, %{
        type: 4,
        data: %{
          content: message
        }
      })
    end

    HandleForms.handle(id, call)

    [
      content: message,
      ephemeral?: true,
      components: [
        %{
          type: 1,
          components: [
            %{
              type: 2,
              style: 1,
              custom_id: id,
              label: "Grande dia"
            }
          ]
        }
      ]
    ]
  end

  @impl true
  def type, do: :slash

  @impl true
  def options,
    do: [
      %{
        type: :string,
        name: "message",
        description: "The message to echo",
        required: true
      }
    ]
end
