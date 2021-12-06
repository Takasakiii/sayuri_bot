defmodule Sayuri.Commands.Counter do
  @behaviour Nosedrum.ApplicationCommand

  alias Sayuri.Modules.HandleForms
  alias Nostrum.Api

  @impl true
  def description, do: "Cria um botão inutil que quando clica ele add + 1"

  def callback(it) do
    new_id = Integer.to_string(it.id)
    {counter, _} = Integer.parse(Enum.at(String.split(it.data.custom_id, "-"), 1))
    n_counter = counter + 1

    HandleForms.handle("#{new_id}-#{n_counter}", &callback/1)

    Api.create_interaction_response(it, %{
      type: 7,
      data: %{
        content: "grande dia",
        components: [
          %{
            type: 1,
            components: [
              %{
                type: 2,
                style: 1,
                custom_id: "#{new_id}-#{n_counter}",
                label: "#{n_counter}"
              }
            ]
          }
        ]
      }
    })
  end

  @impl true
  def command(interaction) do
    id = interaction.id

    HandleForms.handle("#{id}-0", &callback/1)

    [
      content: "grande dia",
      components: [
        %{
          type: 1,
          components: [
            %{
              type: 2,
              style: 1,
              custom_id: "#{id}-0",
              label: "0"
            }
          ]
        }
      ]
    ]
  end

  @impl true
  def type, do: :slash

  @impl true
  def options, do: []
end
