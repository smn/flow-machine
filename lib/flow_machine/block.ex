defmodule FlowMachine.Block do
  @moduledoc """
  A block in a flow, the first block in a flow's
  blocks list is the starting point of a flow
  """
  defstruct uuid: nil,
            name: nil,
            label: nil,
            semantic_label: nil,
            platform_metadata: %{},
            type: nil,
            config: %{},
            exits: []

  @type t :: %__MODULE__{
          uuid: binary,
          name: String.t(),
          label: String.t() | nil,
          semantic_label: String.t() | nil,
          platform_metadata: map,
          type: String.t(),
          config: map,
          exits: [FlowMachine.BlockExit.t()]
        }
end
