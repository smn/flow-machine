defmodule FlowMachine.FlowTest do
  use ExUnit.Case
  doctest FlowMachine.Flow
  alias FlowMachine.Flow

  def find_fixtures!(_ctx) do
    json_fixtures =
      Application.app_dir(:flow_machine, "priv/fixtures/flows/*.json")
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
        assert Flow.load(fixture)
      end)
    end
  end
end
