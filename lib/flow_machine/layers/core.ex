defmodule FlowMachine.Layers.Core do
  @type block :: FlowMachine.Block.t()
  @type context :: FlowMachine.Context.t()
  @type block_exit :: binary

  @spec log(block, context) :: {block_exit, context}
  def log(%{exits: [next_exit], config: config}, context) do
    message = Map.get(config, :message)
    logs = Map.put(context.logs, DateTime.utc_now(), message)
    context = %{context | logs: logs}
    {next_exit, context}
  end

  @spec case_(block, context) :: {block_exit, context}
  def case_(%{exits: exits}, context) do
    {default_exits, test_exits} =
      Enum.split_with(exits, fn
        %{default: true} -> true
        %{test: _test} -> false
      end)

    default_exit = hd(default_exits)

    test_exit =
      Enum.find(test_exits, fn %{test: expression} ->
        case Excellent.evaluate(expression, context) do
          {:ok, 0} -> false
          {:ok, false} -> false
          {:ok, nil} -> false
          {:ok, _is_treated_as_truthy} -> true
          {:error, _reason} -> false
        end
      end)

    {test_exit || default_exit, context}
  end
end
