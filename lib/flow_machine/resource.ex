defmodule FlowMachine.Resource do
  use FlowMachine.SpecLoader

  @moduledoc """
  A Resource describes a collection of localized strings or media resources,
  used when content needs to be presented to Contacts in multiple languages.
  """
  defstruct uuid: nil,
            # text: %{},
            # audio: %{},
            values: [],
            org_id: nil,
            column_count: nil,
            flow_id: nil

  # @type text_resource :: map()
  # @type audio_resource :: map()

  @type t :: %__MODULE__{
          uuid: binary,
          values: [FlowMachine.ResourceDefinition.t()],
          org_id: binary,
          column_count: integer,
          flow_id: binary
          # the documented flow spec suggests this format but
          # the implementation seems to differ from this with a
          # values field
          # text: text_resource,
          # audio: audio_resource
        }

  def load_key(_resource, "uuid", uuid), do: {:ok, [uuid: uuid]}

  def load_key(_resource, "values", values),
    do: {:ok, [values: Enum.map(values, &FlowMachine.ResourceDefinition.load/1)]}

    def load_key(_resource, "columnCount", value), do: {:ok, column_count: value}
    def load_key(_resource, "flowId", value), do: {:ok, flow_id: value}
    def load_key(_resource, "orgId", value), do: {:ok, org_id: value}
end
