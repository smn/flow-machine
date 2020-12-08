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

  def load_key("uuid", value, _flow), do: {:ok, uuid: value}

  def load_key("name", value, _flow), do: {:ok, name: value}

  def load_key("label", value, _flow), do: {:ok, label: value}

  def load_key("lastModified", value, _flow),
    do: {:ok, last_modified: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key("interactionTimeout", value, _flow), do: {:ok, interaction_timeout: value}

  def load_key("platformMetadata", value, _flow), do: {:ok, platform_metadata: value}

  def load_key("supportedModes", value, _flow), do: {:ok, supported_modes: value}

  def load_key("languages", value, _flow), do: {:ok, languages: value}

  def load_key("blocks", value, _flow), do: {:ok, blocks: Enum.map(value, &FlowMachine.Block.load/1)}

  def load_key("exitBlockId", value, _flow), do: {:ok, exit_block_id: value}

  def load_key("firstBlockId", value, _flow), do: {:ok, first_block_id: value}

  def load_key("iconColor", value, _flow), do: {:ok, icon_color: value}

  def load_key("resources", value, _flow),
    do: {:ok, resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key("runCount", value, _flow), do: {:ok, run_count: value}
  def load_key("id", value, _flow), do: {:ok, id: value}
  def load_key("orgId", value, _flow), do: {:ok, org_id: value}
  def load_key("sessions", value, flow), do: {:ok, sessions: [value | flow.sessions]}
end
