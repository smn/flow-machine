defmodule FlowMachine.ResourceDefinition do
  @moduledoc false
  use FlowMachine.SpecLoader

  defstruct uuid: nil,
            language_id: nil,
            content_type: nil,
            modes: [],
            value: nil,
            file_name: nil,
            has_been_fetched: nil,
            resource_uuid: nil,
            column_count: nil,
            org_id: nil

  @type t :: %__MODULE__{
          uuid: binary,
          language_id: binary,
          content_type: binary,
          modes: [binary],
          value: binary,
          file_name: binary | nil,
          has_been_fetched: bool | nil,
          resource_uuid: binary | nil,
          column_count: integer | nil,
          org_id: binary | nil
        }
end
