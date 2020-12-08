defmodule FlowMachine.ContextTest do
  use ExUnit.Case
  doctest FlowMachine.Context
  alias FlowMachine.{Context, TestHelpers}

  describe "parsing" do
    test "sample fixtures"do
      TestHelpers.list_fixtures("priv/fixtures/contexts/*.json")
      |> Enum.each(fn fixture ->
        assert Context.load(fixture)
      end)
    end
  end
end
