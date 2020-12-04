defmodule FlowMachine.Layers.CoreTest do
  use ExUnit.Case
  alias FlowMachine.{Block, BlockExit, Context}
  alias FlowMachine.Core.{Log, RunFlow, Case, Output}

  test "log/2" do
    block_exit = %BlockExit{}

    block = %Block{
      config: %{
        message: "This is a sample log message."
      },
      exits: [block_exit]
    }

    assert {:ok, ^block_exit, ctx} = Log.log(block, %Context{})
    assert [{%DateTime{}, "This is a sample log message."}] = Enum.into(ctx.logs, [])
  end

  test "case_/2" do
    over_18 = %BlockExit{test: "age > 18", label: "over 18"}
    under_18 = %BlockExit{test: "age < 18", label: "under 18"}
    default = %BlockExit{default: true, label: "exactly 18"}

    block = %Block{
      exits: [over_18, under_18, default]
    }

    assert {:ok, ^over_18, ctx} = Case.case_(block, %{"age" => 19})
    assert {:ok, ^under_18, ctx} = Case.case_(block, %{"age" => 17})
    assert {:ok, ^default, ctx} = Case.case_(block, %{"age" => 18})
  end

  test "run_flow/2" do
    block_exit = %BlockExit{}

    block = %Block{
      config: %{
        flow_id: UUID.uuid4()
      },
      exits: [block_exit]
    }

    assert {:ok, ^block_exit, ctx} = RunFlow.run_flow(block, %{})
  end

  test "output/2" do
    block_exit = %BlockExit{}

    block = %Block{
      exits: [block_exit],
      config: %{
        value: "Next year you are @(contact.age + 1) years old"
      }
    }

    assert {:ok, ^block_exit, ctx} = Output.output(block, %{interactions: [], contact: %{age: 20}})
    assert %{
      contact: %{age: 20},
      interactions: [%FlowMachine.BlockInteraction{
        value: "Next year you are 21 years old"
      }]
    }
  end
end
