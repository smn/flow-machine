defmodule FlowMachine.Contact do
  @moduledoc """
  A contact
  """
  use FlowMachine.SpecLoader, manual: true
  defstruct id: nil, properties: []

  @type t :: %__MODULE__{
          id: binary,
          properties: [FlowMachine.ContactProperty.t()]
        }

  def load_key(contact, "id", value), do: %{contact | id: value}

  def load_key(contact, key, value) do
    now = DateTime.utc_now()

    %{
      contact
      | properties: [
          %FlowMachine.ContactProperty{
            contact_property_field_name: key,
            value: value,
            created_at: now,
            updated_at: now
          }
          | contact.properties
        ]
    }
  end
end
