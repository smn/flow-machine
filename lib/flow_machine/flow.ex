defmodule FlowMachine.Flow do
  @moduledoc """
  A Flow represents a set of Blocks and their direct connections.
  """
  use FlowMachine.SpecLoader

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

  def load_key(_flow, "lastModified", value),
    do: {:ok, last_modified: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(_flow, "blocks", value),
    do: {:ok, blocks: Enum.map(value, &FlowMachine.Block.load/1)}

  def load_key(_flow, "resources", value),
    do: {:ok, resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key(flow, "sessions", value), do: {:ok, sessions: [value | flow.sessions]}
end
