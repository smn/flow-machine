defmodule FlowMachine.ContactProperty do
  @moduledoc """
  A property on a contact
  """
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
end
