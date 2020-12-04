defmodule FlowMachine.Core.RunFlow do
  use FlowMachine, :core

  @spec run_flow(block, context) :: {:ok, block_exit, context}
  def run_flow(%{exits: [first_exit | _]}, context) do
    Logger.info("run_flow/2 is not fully understood yet.")
    {:ok, first_exit, context}
  end

end
