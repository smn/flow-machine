defmodule FlowMachine.Layers.CoreTest do
  use ExUnit.Case
  alias FlowMachine.{Block, BlockExit, Context}
  alias FlowMachine.Layers.Core

  test "log/2" do
    block_exit = %BlockExit{}

    block = %Block{
      config: %{
        message: "This is a sample log message."
      },
      exits: [block_exit]
    }

    assert {^block_exit, ctx} = Core.log(block, %Context{})
    assert [{%DateTime{}, "This is a sample log message."}] = Enum.into(ctx.logs, [])
  end

  test "case_/2" do
    over_18 = %BlockExit{test: "@(age > 18)", label: "over 18"}
    under_18 = %BlockExit{test: "@(age < 18)", label: "under 18"}
    default = %BlockExit{default: true, label: "exactly 18"}

    block = %Block{
      exits: [over_18, under_18, default]
    }

    assert {^over_18, ctx} = Core.case_(block, %{"age" => 19})
    assert {^under_18, ctx} = Core.case_(block, %{"age" => 17})
    assert {^default, ctx} = Core.case_(block, %{"age" => 18})
  end
end
