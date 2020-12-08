defmodule FlowMachine.PromptConfig do
  @moduledoc false

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

  @spec load(map) :: {:ok, t} | {:error, atom}
  def load(map) do
    map
    |> Enum.reduce(%__MODULE__{}, fn
      {"kind", value}, prompt_config ->
        %{prompt_config | kind: value}

      {"isResponseRequired", value}, prompt_config ->
        %{prompt_config | is_response_required: value}

      {"prompt", value}, prompt_config ->
        %{prompt_config | prompt: value}

      {"value", value}, prompt_config ->
        %{prompt_config | value: value}

      {"choices", value}, prompt_config ->
        %{
          prompt_config
          | choices:
              Enum.map(value, fn %{"key" => key, "value" => value} ->
                %{key: key, value: value}
              end)
        }

      {"isSubmitted", value}, prompt_config ->
        %{prompt_config | is_submitted: value}
    end)
  end
end
