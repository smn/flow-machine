defmodule FlowMachine.Core.RunFlow do
  @moduledoc false
  use FlowMachine, :core
  require Logger

  @spec run_flow(block, context) :: {:ok, block_exit, context}
  def run_flow(%{exits: [first_exit | _]}, context) do
    Logger.info("run_flow/2 is not fully understood yet.")
    {:ok, first_exit, context}
  end
end
