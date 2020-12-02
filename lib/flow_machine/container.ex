defmodule FlowMachine.Container do
  @moduledoc """
  A Container is a "package" document containing one or more Flow Definitions,
  useful for sharing multiple Flows in a single document.
  """
  defstruct specification_version: nil,
            uuid: nil,
            name: nil,
            description: nil,
            platform_metadata: %{},
            flows: [],
            resources: %{}

  @type t :: %__MODULE__{
          specification_version: String.t(),
          uuid: binary,
          name: String.t(),
          description: String.t(),
          platform_metadata: map,
          flows: [FlowMachine.Flow.t()],
          resources: [FlowMachine.Resource.t()]
        }
end
