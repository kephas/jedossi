defmodule Jedossi do
  import Enum
  def create_store do
	{:ok, _} = Agent.start_link(fn -> %{} end, name: :store)
  end

  def store_value(key, value) do
	Agent.update(:store, fn map -> Map.put(map, key, value) end)
  end

  def get_value(key) do
	Agent.get(:store, fn map -> Map.get(map, key) end)
  end

  def get_all_values() do
	Map.values(Agent.get(:store, fn map -> map end))
  end

  def get_all_keys() do
	Map.keys(Agent.get(:store, fn map -> map end))
  end

  def get_timer(name) do
	case get_value(name) do
	  nil -> []
	  list when is_list(list) -> list
	end
  end

  def start_timer(name) do
	time = System.monotonic_time()

	timer = get_timer(name)

	case timer do
	  [ head | _ ] ->
		case head do
		  {_, _} ->
			store_value(name, [time | timer])

		  start when is_integer(start) ->
			nil
		end
	  [] ->
		store_value(name, [time])
	end
  end

  def stop_timer(name) do
	time = System.monotonic_time()

	timer = get_timer(name)

	case timer do
	  [ head | _ ] ->
		case head do
		  {_, _} ->
			nil

		  start when is_integer(start) ->
			store_value(name, [{time, start} | tl(timer)])
		end
	  [] ->
		store_value(name, [])
	end
  end

  def start_all() do
	map(get_all_keys(), &start_timer(&1))
  end

  def stop_all() do
	map(get_all_keys(), &stop_timer(&1))
  end
end
