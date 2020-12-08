defmodule FlowMachine.Cursor do
  @moduledoc """
  Where we are in a current block
  """
  use FlowMachine.SpecLoader
  defstruct interaction_id: nil, prompt_config: nil

  @type t :: %__MODULE__{
          interaction_id: binary,
          prompt_config: FlowMachine.PromptConfig.t()
        }

  def load_key("interactionId", value), do: {:ok, interaction_id: value}

  def load_key("promptConfig", value),
    do: {:ok, prompt_config: FlowMachine.PromptConfig.load(value)}
end
