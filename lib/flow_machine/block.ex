defmodule FlowMachine.Block.Exit do
  @moduledoc """
  An exit out of a flow
  """
  defstruct uuid: nil,
            label: nil,
            tag: nil,
            destination_block: nil,
            semantic_label: nil,
            test: nil,
            config: %{}

  @type t :: %__MODULE__{
          uuid: UUID.t(),
          label: FlowMachine.Resource.t(),
          tag: String.t(),
          destination_block: UUID.t() | nil,
          semantic_label: String.t() | nil,
          test: String.t() | nil,
          config: map
        }
end

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
          uuid: UUID.t(),
          name: String.t(),
          label: String.t() | nil,
          semantic_label: String.t() | nil,
          platform_metadata: map,
          type: String.t(),
          config: map,
          exits: [FlowMachine.Block.Exit]
        }
end
