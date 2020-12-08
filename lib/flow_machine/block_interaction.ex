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

  def load_key("uuid", value, _block_interaction), do: {:ok, uuid: value}
  def load_key("blockId", value, _block_interaction), do: {:ok, block_id: value}
  def load_key("flowId", value, _block_interaction), do: {:ok, flow_id: value}
  def load_key("entryAt", value, _block_interaction), do: {:ok, entry_at: FlowMachine.Helpers.from_iso8601!(value)}
  def load_key("exitAt", value, _block_interaction), do: {:ok, exit_at: FlowMachine.Helpers.from_iso8601!(value)}
  def load_key("hasResponse", value, _block_interaction), do: {:ok, has_response: value}
  def load_key("value", value, _block_interaction), do: {:ok, value: value}
  def load_key("details", value, _block_interaction), do: {:ok, details: value}
  def load_key("selectedExitId", value, _block_interaction), do: {:ok, selected_exit_id: value}
  def load_key("type", value, _block_interaction), do: {:ok, type: value}
  def load_key("originBlockInteractionId", value, _block_interaction), do: {:ok, origin_block_interaction_id: value}
  def load_key("originFlowId", value, _block_interaction), do: {:ok, origin_flow_id: value}
end
