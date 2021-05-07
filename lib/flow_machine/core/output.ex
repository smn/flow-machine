defmodule FlowMachine.Core.Output do
  @moduledoc false
  require Logger
  use FlowMachine, :core

  @spec output(block, context) :: {:ok, block_exit, context}
  def output(
        %{exits: [only_exit], config: %{value: expression}},
        %{interactions: interactions} = context
      ) do
    Logger.info("Were being very liberal with the %Context here")
    {:ok, value} = Expression.evaluate(expression, context)

    new_interaction = %FlowMachine.BlockInteraction{
      value: value
    }

    context = %{context | interactions: [new_interaction | interactions]}
    {:ok, only_exit, context}
  end
end
