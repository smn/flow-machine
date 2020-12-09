defmodule FlowMachine.Cursor do
  @moduledoc """
  Where we are in a current block
  """
  use FlowMachine.SpecLoader, manual: ["promptConfig"]
  defstruct interaction_id: nil, prompt_config: nil

  @type t :: %__MODULE__{
          interaction_id: binary,
          prompt_config: FlowMachine.PromptConfig.t()
        }

  def load_key(cursor, "promptConfig", value),
    do: %{cursor | prompt_config: FlowMachine.PromptConfig.load(value)}
end
