defmodule FlowMachine.PromptConfig do
  @moduledoc false

  defstruct kind: nil, is_response_required: nil, prompt: nil, value: nil

  @type t :: %__MODULE__{
          kind: binary,
          is_response_required: bool,
          prompt: binary,
          value: any
        }
end
