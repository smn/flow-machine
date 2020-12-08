defmodule FlowMachine.Context do
  @moduledoc """
  Context is the single piece of truth to the state of the current run.
  It's design in such a way that one can pause execution between
  any interactive interaction and resume exactly where one left off.
  The context object is all one needs, and it's 100% JSON-serializable.
  """
  use FlowMachine.SpecLoader

  defstruct id: nil,
            created_at: nil,
            entry_at: nil,
            exit_at: nil,
            delivery_status: nil,
            user_id: nil,
            org_id: nil,
            mode: nil,
            language_id: nil,
            contact: nil,
            session_vars: %{},
            interactions: [],
            nested_flow_block_interaction_id_stack: [],
            reversible_operations: [],
            cursor: nil,
            flows: [],
            first_flow_id: nil,
            resources: %{},
            platform_metadata: %{},
            logs: %{}

  @type t :: %__MODULE__{
          id: binary,
          created_at: DateTime.t(),
          entry_at: DateTime.t() | nil,
          exit_at: DateTime.t() | nil,
          delivery_status: binary,
          user_id: binary | nil,
          org_id: binary | nil,
          mode: binary,
          language_id: binary,
          contact: FlowMachine.Contact.t(),
          session_vars: map,
          interactions: [FlowMachine.BlockInteraction.t()],
          nested_flow_block_interaction_id_stack: [binary],
          reversible_operations: [FlowMachine.ReversibleOperation.t()],
          cursor: FlowMachine.Cursor.t() | nil,
          flows: [FlowMachine.Flow.t()],
          first_flow_id: binary,
          resources: FlowMachine.Resource.t(),
          platform_metadata: map,
          logs: map
        }

  def load_key("id", value), do: {:ok, id: value}

  def load_key("createdAt", value),
    do: {:ok, created_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key("contact", value), do: {:ok, contact: FlowMachine.Contact.load(value)}
  def load_key("cursor", value), do: {:ok, cursor: FlowMachine.Cursor.load(value)}
  def load_key("deliveryStatus", value), do: {:ok, delivery_status: value}

  def load_key("entryAt", value),
    do: {:ok, entry_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key("firstFlowId", value), do: {:ok, first_flow_id: value}
  def load_key("flows", value), do: {:ok, flows: Enum.map(value, &FlowMachine.Flow.load/1)}

  def load_key("interactions", value),
    do: {:ok, interactions: Enum.map(value, &FlowMachine.BlockInteraction.load/1)}

  def load_key("languageId", value), do: {:ok, language_id: value}
  def load_key("mode", value), do: {:ok, mode: value}

  def load_key("nestedFlowBlockInteractionIdStack", value),
    do: {:ok, nested_flow_block_interaction_id_stack: value}

  def load_key("platformMetadata", value), do: {:ok, platform_metadata: value}

  def load_key("resources", value),
    do: {:ok, resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key("sessionVars", value), do: {:ok, session_vars: value}
  def load_key("userId", value), do: {:ok, user_id: value}
end
