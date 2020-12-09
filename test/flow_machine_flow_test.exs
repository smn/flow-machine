defmodule FlowMachine.FlowTest do
  use ExUnit.Case
  doctest FlowMachine.Flow
  import FlowMachine.TestHelpers
  alias FlowMachine.Flow

  describe "parsing" do
    test "sample fixtures" do
      list_fixtures("priv/fixtures/flows/*.json")
      |> Enum.each(fn fixture ->
        assert Flow.load(fixture)
      end)
    end
  end
end
