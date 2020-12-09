defmodule FlowMachine.BlockExit do
  use FlowMachine.SpecLoader

  @moduledoc """
  An exit out of a flow
  """
  defstruct uuid: nil,
            label: nil,
            tag: nil,
            destination_block: nil,
            semantic_label: nil,
            test: nil,
            config: %{},
            default: nil

  @type t :: %__MODULE__{
          uuid: binary,
          label: FlowMachine.Resource.t(),
          tag: String.t(),
          destination_block: binary | nil,
          semantic_label: String.t() | nil,
          test: String.t() | nil,
          config: map,
          default: bool | nil
        }
end
