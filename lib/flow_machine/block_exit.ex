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

  def load_key(_block_exit, "uuid", value), do: {:ok, uuid: value}
  def load_key(_block_exit, "label", value), do: {:ok, label: value}
  def load_key(_block_exit, "tag", value), do: {:ok, tag: value}
  def load_key(_block_exit, "destinationBlock", value), do: {:ok, destination_block: value}
  def load_key(_block_exit, "semanticLabel", value), do: {:ok, semantic_label: value}
  def load_key(_block_exit, "test", value), do: {:ok, test: value}
  def load_key(_block_exit, "config", value), do: {:ok, config: value}
  def load_key(_block_exit, "default", value), do: {:ok, default: value}
end
