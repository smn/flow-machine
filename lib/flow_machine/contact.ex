defmodule FlowMachine.Contact do
  @moduledoc """
  A contact
  """
  defstruct id: nil, properties: []

  @type t :: %__MODULE__{
          id: binary,
          properties: [FlowMachine.ContactProperty.t()]
        }
end
