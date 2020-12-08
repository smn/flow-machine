defmodule FlowMachine.Helpers do
  def from_iso8601!(iso8601) do
    {:ok, datetime, 0} = DateTime.from_iso8601(iso8601)
    datetime
  end
end
