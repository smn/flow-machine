defmodule FlowMachine.Block do
  @moduledoc """
  A block in a flow, the first block in a flow's
  blocks list is the starting point of a flow
  """
  use FlowMachine.SpecLoader

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

  def load_key(_block, "uuid", value), do: {:ok, uuid: value}
  def load_key(_block, "config", value), do: {:ok, config: value}

  def load_key(_block, "exits", value),
    do: {:ok, exits: Enum.map(value, &FlowMachine.BlockExit.load/1)}

  def load_key(_block, "name", value), do: {:ok, name: value}
  def load_key(_block, "label", value), do: {:ok, label: value}
  def load_key(_block, "semanticLabel", value), do: {:ok, semantic_label: value}
  def load_key(_block, "platformMetadata", value), do: {:ok, platform_metadata: value}
  def load_key(_block, "type", value), do: {:ok, type: value}
end
