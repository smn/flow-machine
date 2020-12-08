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
      def load_key(key, value), do: {:error, "load_key/2 not implemented for #{inspect(key)}"}

      # def load_key(key, value, impl), do: {:error, "load_key/3 not implemented for #{inspect key}"}
      defoverridable(load_key: 2)
    end
  end

  def load(mod, map) do
    map
    |> Enum.reduce(
      struct(mod),
      fn {key, value}, impl ->
        {:ok, values} =
          if function_exported?(mod, :load_key, 3) do
            mod.load_key(key, value, impl)
          else
            mod.load_key(key, value)
          end

        values
        |> Enum.reduce(impl, fn {key, value}, impl ->
          Map.put(impl, key, value)
        end)
      end
    )
  end
end
