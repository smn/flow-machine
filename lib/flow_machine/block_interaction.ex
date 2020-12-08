defmodule FlowMachine.BlockInteraction do
  @moduledoc false
  use FlowMachine.SpecLoader

  defstruct uuid: nil,
            block_id: nil,
            flow_id: nil,
            entry_at: nil,
            exit_at: nil,
            has_response: nil,
            value: nil,
            details: nil,
            selected_exit_id: nil,
            type: nil,
            origin_block_interaction_id: nil,
            origin_flow_id: nil

  @type t :: %__MODULE__{
          uuid: binary,
          block_id: binary,
          flow_id: binary,
          entry_at: DateTime.t(),
          exit_at: DateTime.t(),
          has_response: bool,
          value: any,
          details: map,
          selected_exit_id: binary | nil,
          type: binary,
          origin_block_interaction_id: binary | nil,
          origin_flow_id: binary | nil
        }

  def load_key(_block_interaction, "uuid", value), do: {:ok, uuid: value}
  def load_key(_block_interaction, "blockId", value), do: {:ok, block_id: value}
  def load_key(_block_interaction, "flowId", value), do: {:ok, flow_id: value}
  def load_key(_block_interaction, "entryAt", value), do: {:ok, entry_at: FlowMachine.Helpers.from_iso8601!(value)}
  def load_key(_block_interaction, "exitAt", value), do: {:ok, exit_at: FlowMachine.Helpers.from_iso8601!(value)}
  def load_key(_block_interaction, "hasResponse", value), do: {:ok, has_response: value}
  def load_key(_block_interaction, "value", value), do: {:ok, value: value}
  def load_key(_block_interaction, "details", value), do: {:ok, details: value}
  def load_key(_block_interaction, "selectedExitId", value), do: {:ok, selected_exit_id: value}
  def load_key(_block_interaction, "type", value), do: {:ok, type: value}
  def load_key(_block_interaction, "originBlockInteractionId", value), do: {:ok, origin_block_interaction_id: value}
  def load_key(_block_interaction, "originFlowId", value), do: {:ok, origin_flow_id: value}
end
