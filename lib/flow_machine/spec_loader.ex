defmodule FlowMachine.SpecLoader do
  defmacro __using__(_ignored) do
    %{module: mod} = __CALLER__

    quote do
      @type spec_key :: binary
      @type spec_value :: map | list | binary | number

      @spec load(map) :: unquote(mod).t
      def load(map) do
        FlowMachine.SpecLoader.load(unquote(mod), map)
      end

      @spec load_key(spec_key, spec_value) ::
              {:ok, [{atom, spec_value}]}
              | {:error, atom}
      def load_key(key, value), do: {:error, :not_implemented}
      defoverridable(load_key: 2)
    end
  end

  def load(mod, map) do
    map
    |> Enum.reduce(
      struct(mod),
      fn {key, value}, impl ->
        {:ok, values} = mod.load_key(key, value)

        values
        |> Enum.reduce(impl, fn {key, value}, impl ->
          Map.put(impl, key, value)
        end)
      end
    )
  end
end
