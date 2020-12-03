defmodule FlowMachine.BlockInteraction do
  @moduledoc false

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
end
