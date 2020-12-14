defmodule FlowMachine.Context do
  @moduledoc """
  Context is the single piece of truth to the state of the current run.
  It's design in such a way that one can pause execution between
  any interactive interaction and resume exactly where one left off.
  The context object is all one needs, and it's 100% JSON-serializable.
  """
  use FlowMachine.SpecLoader,
    manual: [
      "createdAt",
      "contact",
      "cursor",
      "entryAt",
      "flows",
      "interactions",
      "resources",
      "reversibleOperations",
      "logs"
    ]

  alias FlowMachine.{DeliveryStatus, SupportedModes}

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
          resources: [FlowMachine.ResourceDefinition.t()],
          platform_metadata: map,
          logs: map,
          specification_version: binary | nil
        }

  @doc """
  Create a new %Context{} for the given contact with the given flows.
  This requires _exactly_ one flow in the `flows` list argument

  # Example

    iex> flow_uuid = UUID.uuid4()
    iex> flow = %FlowMachine.Flow{uuid: flow_uuid}
    iex> contact = %FlowMachine.Contact{}
    iex> context = FlowMachine.Context.new(contact, "user_id", "org_id", [flow], "ENG")
    iex> %FlowMachine.Context{first_flow_id: flow_uuid, flows: [flow], contact: contact, user_id: "user_id", org_id: "org_id", language_id: "ENG"} == context

  """
  @spec new(
          FlowMachine.Contact.t(),
          user_id :: binary,
          org_id :: binary,
          [FlowMachine.Flow.t()],
          language_id :: binary,
          mode :: binary | nil,
          resources :: [FlowMachine.ResourceDefinition.t()]
        ) :: t
  def new(
        contact,
        user_id,
        org_id,
        [flow],
        language_id,
        mode \\ nil,
        resources \\ []
      ),
      do: %__MODULE__{
        id: UUID.uuid4(),
        user_id: user_id,
        org_id: org_id,
        language_id: language_id,
        created_at: DateTime.utc_now(),
        delivery_status: DeliveryStatus.status_queued(),
        mode: mode || SupportedModes.mode_offline(),
        resources: resources,
        contact: contact,
        flows: [flow],
        first_flow_id: flow.uuid
      }

  @spec initialize(t) :: t
  def initialize(context) do
    %{
      context
      | delivery_status: DeliveryStatus.status_in_progress(),
        entry_at: DateTime.utc_now(),
        cursor: %FlowMachine.Cursor{}
    }
  end

  # @doc """
  # """
  # @spec find_next_block_on_active_flow(context) ::
  #         {:ok, FlowMachine.BlockInteraction.t()}
  #         | {:error, :block_interaction_not_found}
  # def find_next_block_on_active_flow(%{cursor: cursor} = context) do
  #   {:ok, flow} = get_active_flow_from(context)

  #   if is_nil(cursor) do
  #     hd(flow.blocks)
  #   else
  #     interaction = find_interaction_with(context, cursor.interaction_id)
  #     find_next_block_from(context, interaction)
  #   end
  # end

  # @spec find_next_block_from(context, FlowMachine.BlockInteraction.t()) :: FlowMachine.Block.t()
  # def find_next_block_from(
  #       context,
  #       %{block_id: block_id, selected_exit_id: selected_exit_id} = _block_interaction
  #     )
  #     when not is_nil(selected_exit_id) do
  #   block = find_block_on_active_flow_with(context, block_id)

  #   %{destination_block: destination_block} =
  #     FlowMachine.Block.find_block_exit_with(block, selected_exit_id)

  #   %{blocks: blocks} = get_active_flow_from(context)

  #   Enum.find(blocks, fn
  #     %{uuid: ^destination_block} -> true
  #     _anything_else -> false
  #   end)
  # end

  # @doc """
  # Get the flow id for the active flow from the context
  # """
  # @spec get_active_flow_id_from(context) :: binary
  # def get_active_flow_id_from(%{
  #       nested_flow_block_interaction_id_stack: [],
  #       first_flow_id: first_flow_id
  #     }),
  #     do: first_flow_id

  # def get_active_flow_id_from(%{nested_flow_block_interaction_id_stack: stack} = context) do
  #   block_interaction = block_find_interaction_with(context, tl(stack))
  #   find_nested_flow_id_for(context, block_interaction)
  # end

  # @spec find_nested_flow_id_for(context, FlowMachine.BlockInteraction.t()) :: binary
  # def find_nested_flow_id_for(context, block_interaction) do
  #   flow = find_flow_with(context, block_interaction.flow_id)
  #   run_flow_block = FlowMachine.Flow.find_block_with(flow, block_interaction.block_id)
  #   run_flow_block.flow_id
  # end

  # @spec get_active_flow_from(t) :: {:ok, FlowMachine.Flow.t()}
  # def get_active_flow_from(%{cursor: nil, flows: flows}), do: {:ok, hd(flows)}

  # @spec find_block_on_active_flow_with(context, binary) :: FlowMachine.BlockInteraction.t()
  # def find_block_on_active_flow_with(context, uuid) do
  #   FlowMachine.Flow.find_block_with(get_active_flow_from(context), uuid)
  # end

  # @doc """
  # Find the last interaction with the given UUID
  # """
  # @spec find_interaction_with(uuid :: binary, context) ::
  #         FlowMachine.BlockInteraction.t() | nil
  # def find_interaction_with(%{interactions: interactions} = _context, uuid) do
  #   interactions
  #   |> Enum.reverse()
  #   |> Enum.find(fn
  #     %{uuid: ^uuid} -> true
  #     _anything_else -> false
  #   end)
  # end

  def load_key(context, "createdAt", value),
    do: %{context | created_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(context, "contact", value),
    do: %{context | contact: FlowMachine.Contact.load(value)}

  def load_key(context, "cursor", value), do: %{context | cursor: FlowMachine.Cursor.load(value)}

  def load_key(context, "entryAt", value),
    do: %{context | entry_at: FlowMachine.Helpers.from_iso8601!(value)}

  def load_key(context, "flows", value),
    do: %{context | flows: Enum.map(value, &FlowMachine.Flow.load/1)}

  def load_key(context, "interactions", value),
    do: %{context | interactions: Enum.map(value, &FlowMachine.BlockInteraction.load/1)}

  def load_key(context, "resources", value),
    do: %{context | resources: Enum.map(value, &FlowMachine.Resource.load/1)}

  def load_key(context, "reversibleOperations", value),
    do: %{
      context
      | reversible_operations: Enum.map(value, &FlowMachine.ReversibleOperation.load/1)
    }

  def load_key(context, "logs", value),
    do: %{
      context
      | logs:
          value
          |> Enum.map(fn {key, value} ->
            {FlowMachine.Helpers.from_iso8601!(key), value}
          end)
          |> Enum.into(%{})
    }
end
