defmodule FlowMachine.Context do
  @moduledoc """
  Context is the single piece of truth to the state of the current run.
  It's design in such a way that one can pause execution between
  any interactive interaction and resume exactly where one left off.
  The context object is all one needs, and it's 100% JSON-serializable.
  """
  use FlowMachine.SpecLoader

  defstruct uuid: nil,
            id: nil,
            created_at: nil,
            entry_at: nil,
            exit_at: nil,
            description: nil,
            delivery_status: nil,
            user_id: nil,
            org_id: nil,
            mode: nil,
            name: nil,
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
            logs: %{},
            specification_version: nil

  @type t :: %__MODULE__{
          uuid: binary | nil,
          id: binary,
          created_at: DateTime.t(),
          entry_at: DateTime.t() | nil,
          exit_at: DateTime.t() | nil,
          description: binary | nil,
          delivery_status: binary,
          user_id: binary | nil,
          org_id: binary | nil,
          mode: binary,
          name: binary | nil,
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
          logs: map,
          specification_version: binary | nil
        }

  def load_key(_context, "createdAt", value),
    do: {:ok, created_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(_context, "contact", value), do: {:ok, contact: FlowMachine.Contact.load(value)}
  def load_key(_context, "cursor", value), do: {:ok, cursor: FlowMachine.Cursor.load(value)}

  def load_key(_context, "entryAt", value),
    do: {:ok, entry_at: FlowMachine.Helpers.from_iso8601!(value)}


  def load_key(_context, "flows", value),
    do: {:ok, flows: Enum.map(value, &FlowMachine.Flow.load/1)}

  def load_key(_context, "interactions", value),
    do: {:ok, interactions: Enum.map(value, &FlowMachine.BlockInteraction.load/1)}

  def load_key(_context, "resources", value),
    do: {:ok, resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key(_context, "reversibleOperations", value),
    do: {:ok, reversible_operations: Enum.map(value, &FlowMachine.ReversibleOperation.load/1)}

  def load_key(_context, "logs", value),
    do:
      {:ok,
       logs:
         value
         |> Enum.map(fn {key, value} ->
           {FlowMachine.Helpers.from_iso8601!(key), value}
         end)
         |> Enum.into(%{})}
end
