defmodule FlowMachine.ReversibleOperation do
  @moduledoc """
  See sp2 - Immutable updater of objects using JSON operation
  https://github.com/phenyl/sp2

  Allows one to expression operations needing to happen on
  an object in JSON

  `forward` & `reverse` should be something akin to
  sp2's `NonBreakingUpdateOperation`
  """
  use FlowMachine.SpecLoader

  defstruct interaction_id: nil, forward: nil, reverse: nil

  @type t :: %__MODULE__{
          interaction_id: binary,
          forward: map,
          reverse: map
        }
end
