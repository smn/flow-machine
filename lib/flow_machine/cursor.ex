defmodule FlowMachine.Cursor do
  @moduledoc """
  Where we are in a current block
  """
  defstruct interaction_id: nil, prompt_config: nil

  @type t :: %__MODULE__{
          interaction_id: binary,
          prompt_config: FlowMachine.PromptConfig.t()
        }
end
