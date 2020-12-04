defmodule FlowMachine.Core.Case do
  use FlowMachine, :core

  @spec case_(block, context) :: {:ok, block_exit, context}
  def case_(%{exits: exits}, context) do
    {default_exits, test_exits} =
      Enum.split_with(exits, fn
        %{default: true} -> true
        %{test: _test} -> false
      end)

    default_exit = hd(default_exits)

    test_exit =
      Enum.find(test_exits, fn %{test: expression} ->
        case Excellent.evaluate_block(expression, context) do
          {:ok, 0} -> false
          {:ok, false} -> false
          {:ok, nil} -> false
          {:ok, _is_treated_as_truthy} -> true
          {:error, _reason} -> false
        end
      end)

    {:ok, test_exit || default_exit, context}
  end
end
