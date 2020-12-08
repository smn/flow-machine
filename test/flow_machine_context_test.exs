defmodule FlowMachine.ContextTest do
  use ExUnit.Case
  doctest FlowMachine.Context
  alias FlowMachine.Context

  def find_fixtures!(_ctx) do
    json_fixtures =
      Application.app_dir(:flow_machine, "priv/fixtures/contexts/*.json")
      |> Path.wildcard()
      |> Enum.map(fn path ->
         path
         |> File.read!()
         |> Jason.decode!()
      end)

    {:ok, json_fixtures: json_fixtures}
  end

  describe "parsing" do
    setup :find_fixtures!

    test "sample fixtures", %{json_fixtures: json_fixtures} do
      json_fixtures
      |> Enum.each(fn fixture ->
        assert Context.load(fixture)
      end)
    end
  end
end