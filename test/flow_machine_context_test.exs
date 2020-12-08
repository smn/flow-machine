defmodule FlowMachine.ContextTest do
  use ExUnit.Case
  doctest FlowMachine.Context
  alias FlowMachine.Context

  setup do
    :ok
  end

  def json_fixture(path) do
    Application.app_dir(:flow_machine, "priv/fixtures/#{path}")
    |> File.read!()
    |> Jason.decode!()
  end

  describe "parsing" do
    test "sample fixture" do
      data = json_fixture("2019-10-08-case-block-eval-issue.json")
      context = Context.load(data)
      IO.inspect(context, label: "context")
      assert false
    end
  end
end
