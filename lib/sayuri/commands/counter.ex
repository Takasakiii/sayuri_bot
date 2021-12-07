defmodule Sayuri.Commands.Counter do
  @behaviour Nosedrum.ApplicationCommand

  alias Sayuri.Modules.HandleFormsEts
  alias Nostrum.Api

  @impl true
  def description, do: "Cria um botão inutil que quando clica ele add + 1"

  def callback(it, {old_id, counter}) do
    new_id = Integer.to_string(it.id)
    n_counter = counter + 1

    HandleFormsEts.add_form(new_id, {new_id, n_counter}, &callback/2)
    HandleFormsEts.delete_form(old_id)

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
                custom_id: new_id,
                label: n_counter
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
    id = Integer.to_string(id)
    HandleFormsEts.add_form(id, {id, 0}, &callback/2)

    [
      content: "grande dia",
      components: [
        %{
          type: 1,
          components: [
            %{
              type: 2,
              style: 1,
              custom_id: id,
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
