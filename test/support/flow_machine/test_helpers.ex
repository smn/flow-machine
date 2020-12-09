defmodule FlowMachine.TestHelpers do
  def load_fixture(path) do
    path
    |> File.read!()
    |> Jason.decode!()
  end

  def list_fixtures(path) do
    Application.app_dir(:flow_machine, path)
    |> Path.wildcard()
    |> Enum.map(&load_fixture/1)
  end
end
