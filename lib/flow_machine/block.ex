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

  def load_key("uuid", value, _block), do: {:ok, uuid: value}
  def load_key("config", value, _block), do: {:ok, config: value}
  def load_key("exits", value, _block), do: {:ok, exits: Enum.map(value, &FlowMachine.BlockExit.load/1)}
  def load_key("name", value, _block), do: {:ok, name: value}
  def load_key("label", value, _block), do: {:ok, label: value}
  def load_key("semanticLabel", value, _block), do: {:ok, semantic_label: value}
  def load_key("platformMetadata", value, _block), do: {:ok, platform_metadata: value}
  def load_key("type", value, _block), do: {:ok, type: value}
end
