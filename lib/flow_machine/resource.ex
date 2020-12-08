defmodule FlowMachine.Resource do
  use FlowMachine.SpecLoader

  @moduledoc """
  A Resource describes a collection of localized strings or media resources,
  used when content needs to be presented to Contacts in multiple languages.
  """
  defstruct uuid: nil,
            # text: %{},
            # audio: %{},
            values: []

  # @type text_resource :: map()
  # @type audio_resource :: map()

  @type t :: %__MODULE__{
          uuid: binary,
          values: [any]
          # the documented flow spec suggests this format but
          # the implementation seems to differ from this with a
          # values field
          # text: text_resource,
          # audio: audio_resource
        }

  def load_key("uuid", uuid), do: {:ok, [uuid: uuid]}
  def load_key("values", values), do: {:ok, [values: values]}
end
