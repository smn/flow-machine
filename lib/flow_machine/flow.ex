defmodule FlowMachine.Flow do
  @moduledoc """
  A Flow represents a set of Blocks and their direct connections.
  """
  defstruct uuid: nil,
            name: nil,
            label: nil,
            last_modified: nil,
            interaction_timeout: nil,
            platform_metadata: %{},
            supported_modes: [],
            languages: [],
            blocks: []

  @type t :: %__MODULE__{
          uuid: UUID.t(),
          name: String.t(),
          label: String.t() | nil,
          last_modified: DateTime.t(),
          interaction_timeout: integer,
          platform_metadata: map,
          supported_modes: [String.t()],
          languages: [String.t()],
          blocks: FlowMachine.Block.t()
        }
end
