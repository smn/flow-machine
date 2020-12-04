defmodule FlowMachine do
  @moduledoc """
  Documentation for `FlowMachine`.
  """

  def core do
    quote do
      require Logger
      @type block :: FlowMachine.Block.t()
      @type context :: FlowMachine.Context.t()
      @type block_exit :: binary
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
