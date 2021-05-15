defmodule FlowMachine.ContactProperty do
  @moduledoc """
  A property on a contact
  """
  use FlowMachine.SpecLoader, manual: ["created_at", "updated_at", "deleted_at"]

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

  def load_key(contact_property, "created_at", value),
    do: %{contact_property | created_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(contact_property, "updated_at", value),
    do: %{contact_property | updated_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(contact_property, "deleted_at", value),
    do: %{contact_property | deleted_at: FlowMachine.Helpers.from_iso8601!(value)}
end
