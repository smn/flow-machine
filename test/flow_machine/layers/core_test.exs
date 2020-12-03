defmodule FlowMachine.Layers.CoreTest do
  use ExUnit.Case
  alias FlowMachine.Layers.Core

  test "log/1" do
    block = %FlowMachine.Block{
      config: %{
        message: "This is a sample log message."
      },
      exits: ["next-exit"]
    }

    assert {"next-exit", ctx} = Core.log(block, %FlowMachine.Context{})
    assert [{%DateTime{}, "This is a sample log message."}] = Enum.into(ctx.logs, [])
  end
end
