defmodule FlowMachine.Session do
  @moduledoc false
  use FlowMachine.SpecLoader
  defstruct []

  @type t :: %__MODULE__{}
  def load_key(_, _), do: {:error, :not_implemented}
end
