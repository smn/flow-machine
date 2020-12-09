defmodule FlowMachine.RunnerTest do
  use ExUnit.Case
  doctest FlowMachine.Runner
  alias FlowMachine.{Context, Runner}
  import FlowMachine.TestHelpers

  def context!(_) do
    {:ok, context: %Context{}}
  end

  describe "running" do
    setup :context!

    test "a flow", %{context: context} do
      [fixture] = load_fixture("priv/fixtures/flows/Flows-1607486601464.json")
      flow = FlowMachine.Flow.load(fixture)

      assert {:ok, cursor} = Runner.run(context)
    end
  end
end
