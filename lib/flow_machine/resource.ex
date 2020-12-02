defmodule FlowMachine.Resource do
  @moduledoc """
  A Resource describes a collection of localized strings or media resources,
  used when content needs to be presented to Contacts in multiple languages.
  """
  defstruct text: %{}, audio: %{}

  @type text_resource :: map()
  @type audio_resource :: map()

  @type t :: %__MODULE__{
          text: text_resource,
          audio: audio_resource
        }
end
