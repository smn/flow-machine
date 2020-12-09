defmodule FlowMachine.RunnerTest do
  use ExUnit.Case
  doctest FlowMachine.Runner
  alias FlowMachine.{Context, Runner}

  def context!(_) do
    {:ok, context: %Context{}}
  end

  describe "running" do
    setup :context!

    test "a flow", %{context: context} do
      assert {:ok, cursor} = Runner.run(context)
    end
  end
end
