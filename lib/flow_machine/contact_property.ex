defmodule FlowMachine.ContactProperty do
  @moduledoc """
  A property on a contact
  """
  use FlowMachine.SpecLoader

  defstruct value: nil,
            contact_property_field_name: nil,
            created_at: nil,
            updated_at: nil,
            deleted_at: nil

  @type t :: %__MODULE__{
          value: any,
          contact_property_field_name: binary,
          created_at: DateTime.t(),
          updated_at: DateTime.t(),
          deleted_at: DateTime.t() | nil
        }

  def load_key("value", value, _contact_property), do: {:ok, value: value}
  def load_key("contactPropertyFieldName", value, _contact_property), do: {:ok, contact_property_field_name: value}

  def load_key("createdAt", value, _contact_property),
    do: {:ok, created_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key("updatedAt", value, _contact_property),
    do: {:ok, updated_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key("deletedAt", value, _contact_property),
    do: {:ok, deleted_at: FlowMachine.Helpers.from_iso8601!(value)}
end
