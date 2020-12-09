defmodule FlowMachine.Flow do
  @moduledoc """
  A Flow represents a set of Blocks and their direct connections.
  """
  use FlowMachine.SpecLoader, manual: ["lastModified", "blocks", "sessions"]

  defstruct id: nil,
            org_id: nil,
            uuid: nil,
            name: nil,
            label: nil,
            last_modified: nil,
            interaction_timeout: nil,
            platform_metadata: %{},
            supported_modes: [],
            languages: [],
            blocks: [],
            first_block_id: nil,
            exit_block_id: nil,
            icon_color: nil,
            run_count: nil,
            sessions: []

  @type t :: %__MODULE__{
          id: binary | nil,
          org_id: binary | nil,
          uuid: binary,
          name: binary,
          label: binary | nil,
          last_modified: DateTime.t(),
          interaction_timeout: integer,
          platform_metadata: map,
          supported_modes: [binary],
          languages: [binary],
          blocks: FlowMachine.Block.t(),
          first_block_id: binary,
          exit_block_id: binary,
          icon_color: binary | nil,
          run_count: number,
          sessions: [map]
        }

  def load_key(flow, "lastModified", value),
    do: %{flow | last_modified: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(flow, "blocks", value),
    do: %{flow | blocks: Enum.map(value, &FlowMachine.Block.load/1)}

  # def load_key(flow, "resources", value),
  #   do: %{flow | resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key(flow, "sessions", value), do: %{flow | sessions: [value | flow.sessions]}
end
