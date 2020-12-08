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

      @spec load_key(spec_key, spec_value, unquote(mod).t) ::
              {:ok, [{atom, spec_value}]}
              | {:error, atom}
      def load_key(key, value, impl), do: {:error, "#{unquote(mod)}.load_key/3 not implemented for #{inspect(key)}"}

      # def load_key(key, value, impl), do: {:error, "load_key/3 not implemented for #{inspect key}"}
      defoverridable(load_key: 3)
    end
  end

  def load(mod, map) do
    map
    |> Enum.reduce(
      struct(mod),
      fn {key, value}, impl ->
        {:ok, values} = mod.load_key(key, value, impl)

        values
        |> Enum.reduce(impl, fn {key, value}, impl ->
          Map.put(impl, key, value)
        end)
      end
    )
  end
end
