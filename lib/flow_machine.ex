defmodule FlowMachine do
  @moduledoc """
  Documentation for `FlowMachine`.
  """
  def core do
    quote do
      @type block :: FlowMachine.Block.t()
      @type context :: FlowMachine.Context.t()
      @type block_exit :: binary

      import FlowMachine
      import FlowMachine.Helpers
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(which) when is_list(which) do
    Enum.each(which, &apply(__MODULE__, &1, []))
  end
end
