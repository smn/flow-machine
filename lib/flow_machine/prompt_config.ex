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

      def load_key(_prompt_config, "kind", value), do: {:ok, kind: value}

      def load_key(_prompt_config, "isResponseRequired", value), do: {:ok, is_response_required: value}

      def load_key(_prompt_config, "prompt", value), do: {:ok, prompt: value}

      def load_key(_prompt_config, "value", value), do: {:ok, value: value}

      def load_key(_prompt_config, "choices", value), do: {:ok, choices:
              Enum.map(value, fn %{"key" => key, "value" => value} ->
                %{key: key, value: value}
              end)
        }

      def load_key(_prompt_config, "isSubmitted", value), do: {:ok, is_submitted: value}
end
