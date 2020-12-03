defmodule FlowMachine.Layers.Core do
  @type block :: FlowMachine.Block.t()
  @type context :: FlowMachine.Context.t()
  @type block_exit :: binary

  @spec log(block, context) :: {block_exit, context}
  def log(%{exits: [next_exit], config: config}, ctx) do
    message = Map.get(config, :message)
    logs = Map.put(ctx.logs, DateTime.utc_now(), message)
    ctx = %{ctx | logs: logs}
    {next_exit, ctx}
  end
end
