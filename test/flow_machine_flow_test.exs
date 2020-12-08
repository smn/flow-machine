defmodule FlowMachine.FlowTest do
  use ExUnit.Case
  doctest FlowMachine.Flow
  alias FlowMachine.{Flow, TestHelpers}

  describe "parsing" do
    test "sample fixtures" do
      TestHelpers.list_fixtures("priv/fixtures/flows/*.json")
      |> Enum.each(fn fixture ->
        assert Flow.load(fixture)
      end)
    end
  end
end
