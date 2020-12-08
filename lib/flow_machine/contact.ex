defmodule FlowMachine.Contact do
  @moduledoc """
  A contact
  """
  use FlowMachine.SpecLoader
  defstruct id: nil, properties: []

  @type t :: %__MODULE__{
          id: binary,
          properties: [FlowMachine.ContactProperty.t()]
        }

  def load_key("id", value), do: {:ok, id: value}

  def load_key("properties", value),
    do: {:ok, properties: FlowMachine.ContactProperty.load(value)}
end
