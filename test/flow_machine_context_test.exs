defmodule FlowMachine.ContextTest do
  use ExUnit.Case
  doctest FlowMachine.Context
  import FlowMachine.TestHelpers
  alias FlowMachine.Context

  describe "parsing" do
    test "sample fixtures" do
      list_fixtures("priv/fixtures/contexts/*.json")
      |> Enum.each(fn fixture ->
        assert Context.load(fixture)
      end)
    end
  end
end
