defmodule FlowMachine.RunnerTest do
  use ExUnit.Case
  doctest FlowMachine.Runner
  alias FlowMachine.{Context, Runner}
  import FlowMachine.TestHelpers

  def context_for(flow_file) do
    [fixture] = load_fixture(flow_file)
    flow = FlowMachine.Flow.load(fixture)
    %Context{flows: [flow]}
  end

  describe "running" do
    test "a flow" do
      context = context_for("priv/fixtures/flows/Flows-1607486601464.json")
      assert {:ok, cursor} = Runner.run(context)
    end
  end
end
