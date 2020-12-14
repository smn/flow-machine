defmodule FlowMachine.ContainerTest do
  use ExUnit.Case
  doctest FlowMachine.Container
  import FlowMachine.TestHelpers
  alias FlowMachine.Container

  describe "parsing" do
    test "sample fixtures" do
      list_fixtures("priv/fixtures/containers/*.json")
      |> Enum.each(fn fixture ->
        assert Container.load(fixture)
      end)
    end
  end
end
