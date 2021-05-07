defmodule FlowMachine.PromptConfig do
  @moduledoc false
  use FlowMachine.SpecLoader, manual: ["choices"]

  defstruct kind: nil,
            is_response_required: nil,
            is_submitted: nil,
            prompt: nil,
            value: nil,
            choices: []

  @type t :: %__MODULE__{
          kind: binary,
          is_response_required: bool,
          is_submitted: bool,
          prompt: binary,
          value: any,
          choices: [
            %{
              key: binary,
              value: binary
            }
          ]
        }

  def load_key(prompt_config, "choices", value),
    do: %{
      prompt_config
      | choices:
          Enum.map(value, fn %{"key" => key, "value" => value} ->
            %{key: key, value: value}
          end)
    }
end
