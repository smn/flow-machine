defmodule FlowMachineTest do
  use ExUnit.Case
  doctest FlowMachine

  test "greets the world" do
    assert FlowMachine.hello() == :world
  end
end
