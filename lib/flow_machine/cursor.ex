defmodule FlowMachine.Cursor do
  @moduledoc """
  Where we are in a current block
  """
  use FlowMachine.SpecLoader, manual: ["prompt_config"]
  defstruct interaction_id: nil, prompt_config: nil

  @type t :: %__MODULE__{
          interaction_id: binary | nil,
          prompt_config: FlowMachine.PromptConfig.t() | nil
        }

  @spec from_context(FlowMachine.Context.t()) :: t
  def from_context(%{cursor: cursor} = context) do
    [block_interaction | _] =
      context.interactions
      |> Enum.reverse()
      |> Enum.filter(fn %{uuid: uuid} -> uuid == cursor.interaction_id end)

    %__MODULE__{
      interaction_id: block_interaction.uuid
      # prompt_config: FlowMachine.PromptConfig.from_interaction(block_interaction)
    }
  end

  def load_key(cursor, "prompt_config", value),
    do: %{cursor | prompt_config: FlowMachine.PromptConfig.load(value)}
end
