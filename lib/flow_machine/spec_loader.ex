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

      @spec load_key(unquote(mod).t, spec_key, spec_value) ::
              {:ok, [{atom, spec_value}]}
              | {:error, atom}
      def load_key(impl, key, value),
        do: {:error, :not_implemented}

      defoverridable(load_key: 3)
    end
  end

  def load(mod, map) do
    struct_string_keys =
      mod.__struct__
      |> Map.keys()
      |> Enum.map(&to_string/1)

    map
    |> Enum.reduce(
      struct(mod),
      fn {key, value}, impl ->
        response =
          try do
            # give the implementation a change to load it manually
            mod.load_key(impl, key, value)
          rescue
            # if not implemented, attempt to load it as a struct key
            FunctionClauseError ->
              {:error, :not_implemented}
          end

        {:ok, values} =
          case response do
            {:ok, values} ->
              {:ok, values}

            {:error, :not_implemented} ->
              attempt_struct_key = Macro.underscore(key)

              if Enum.member?(struct_string_keys, attempt_struct_key) do
                {:ok, Keyword.new([{String.to_existing_atom(attempt_struct_key), value}])}
              else
                {:error, :invalid_struct_key}
              end
          end

        values
        |> Enum.reduce(impl, fn {key, value}, impl ->
          Map.put(impl, key, value)
        end)
      end
    )
  end
end
