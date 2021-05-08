defmodule FlowMachine.Block do
  @moduledoc """
  A block in a flow, the first block in a flow's
  blocks list is the starting point of a flow
  """
  use FlowMachine.SpecLoader, manual: ["exits"]

  defstruct uuid: nil,
            name: nil,
            label: nil,
            semantic_label: nil,
            vendor_metadata: %{},
            type: nil,
            config: %{},
            exits: []

  @type t :: %__MODULE__{
          uuid: binary,
          name: String.t(),
          label: String.t() | nil,
          semantic_label: String.t() | nil,
          vendor_metadata: map,
          type: String.t(),
          config: map,
          exits: [FlowMachine.BlockExit.t()]
        }

  def load_key(block, "exits", value),
    do: %{block | exits: Enum.map(value, &FlowMachine.BlockExit.load/1)}
end
