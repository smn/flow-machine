defmodule FlowMachine.Runner do
  @moduledoc false

  @type context :: FlowMachine.Context.t()
  @type cursor :: FlowMachine.Cursor.t()
  @type flow :: FlowMachine.Flow.t()

  alias FlowMachine.Context

  @spec run(context) ::
          {:ok, context} | {:error, atom}
  def run(%{cursor: nil} = context),
    do:
      context
      |> Context.initialize()
      |> run()

  def run(%{flows: [flow]} = context) do
    # NOTE:
    # the spec allows for multiple flows to be defined for a context, we're not supporting
    # that yet as I don't know how that would work?
    run_flow(context, flow)
  end

  def run_flow(context, _flow) do
    {:ok, context}
  end
end
