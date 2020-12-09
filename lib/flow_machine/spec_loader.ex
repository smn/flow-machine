defmodule FlowMachine.SpecLoader do
  @moduledoc """
  A macro to help loading of JSON floip specs into structs.
  It will automatically convert `camelCase` key names to
  `snake_case` keys if they're in the struct definition.

  Some keys need some extra help when loading, for when that is the
  case list those key names under the `manual` key. Setting
  `manual` to `true` means _all_ fields will be loaded manually.

  # Example

    defmodule FlowMachine.SomeSpecType do
      use FlowMachine.SpecLoader
    end

    defmodule FlowMachiine.SomeSpecType do
      use FlowMachine.SpecLoader, manual: ["someField"]

      def load_key(some_spec, "someField", value) do
        %{some_spec | some_field: parse(value)}
      end
    end
  """
  defmacro __using__(opts) do
    manually_loaded_fields = Keyword.get(opts, :manual, [])
    %{module: mod} = __CALLER__

    quote do
      @type spec_key :: binary
      @type spec_value :: map | list | binary | number

      @spec load(map) :: unquote(mod).t
      @spec load([map]) :: [unquote(mod).t]
      def load(list) when is_list(list), do: Enum.map(list, &load/1)
      def load(map) when is_map(map) do
        FlowMachine.SpecLoader.load(unquote(mod), map, unquote(manually_loaded_fields))
      end

      @spec load_key(unquote(mod).t, spec_key, spec_value) :: unquote(mod).t | {:error, atom}
      def load_key(impl, key, value),
        do: {:error, :not_implemented}

      defoverridable(load_key: 3)
    end
  end

  def load(mod, map, true) do
    all_keys =
      mod.__struct__
      |> Map.keys()
      |> Enum.map(&to_string/1)

    load(mod, map, all_keys)
  end

  def load(mod, map, manually_loaded_fields) do
    {manual_fields, auto_fields} =
      Enum.split_with(map, fn {key, _value} -> Enum.member?(manually_loaded_fields, key) end)

    impl =
      manual_fields
      |> Enum.reduce(struct(mod), fn {key, value}, impl ->
        mod.load_key(impl, key, value)
      end)

    auto_fields
    |> Enum.reduce(impl, fn {key, value}, impl ->
      struct_key =
        key
        |> Macro.underscore()
        |> String.to_existing_atom()

      Map.put(impl, struct_key, value)
    end)
  end
end
