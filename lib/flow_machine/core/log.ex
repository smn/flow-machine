defmodule FlowMachine.Core.Log do
  use FlowMachine, :core

  @spec log(block, context) :: {:ok, block_exit, context}
  def log(%{exits: [next_exit], config: config}, context) do
    message = Map.get(config, :message)
    logs = Map.put(context.logs, DateTime.utc_now(), message)
    context = %{context | logs: logs}
    {:ok, next_exit, context}
  end
end
