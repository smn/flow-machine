defmodule FlowMachine.PromptConfig do
  @moduledoc false
  use FlowMachine.SpecLoader

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

      def load_key("kind", value, _prompt_config), do: {:ok, kind: value}

      def load_key("isResponseRequired", value, _prompt_config), do: {:ok, is_response_required: value}

      def load_key("prompt", value, _prompt_config), do: {:ok, prompt: value}

      def load_key("value", value, _prompt_config), do: {:ok, value: value}

      def load_key("choices", value, _prompt_config), do: {:ok, choices:
              Enum.map(value, fn %{"key" => key, "value" => value} ->
                %{key: key, value: value}
              end)
        }

      def load_key("isSubmitted", value, _prompt_config), do: {:ok, is_submitted: value}
end
