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

  def load_key("uuid", value), do: {:ok, uuid: value}
  def load_key("languageId", value), do: {:ok, language_id: value}
  def load_key("contentType", value), do: {:ok, content_type: value}
  def load_key("modes", value), do: {:ok, modes: value}
  def load_key("value", value), do: {:ok, value: value}
  def load_key("fileName", value), do: {:ok, file_name: value}
  def load_key("hasBeenFetched", value), do: {:ok, has_been_fetched: value}
  def load_key("resourceUuid", value), do: {:ok, resource_uuid: value}
  def load_key("columnCount", value), do: {:ok, column_count: value}
  def load_key("orgId", value), do: {:ok, org_id: value}
end
