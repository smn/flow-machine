defmodule FlowMachine.Runner do
  @moduledoc false

  @spec run(context :: FlowMachine.Context.t()) ::
          {:ok, FlowMachine.Cursor.t() | nil} | {:error, atom}
  def run(context) do
    {:ok, nil}
  end
end
