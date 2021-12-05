defmodule Sayuri.Commands.Echo do
  @behaviour Nosedrum.ApplicationCommand

  @impl true
  def description, do: "Echos a message grande dia"

  @impl true
  def command(interaction) do
    [%{name: "message", value: message}] = interaction.data.options

    [
      content: message
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
