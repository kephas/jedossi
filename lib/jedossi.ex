defmodule Jedossi do
  def create_store do
	{:ok, _} = Agent.start_link(fn -> %{} end, name: :store)
  end

  def store_value(key, value) do
	Agent.update(:store, fn map -> Map.put(map, key, value) end)
  end

  def get_value(key) do
	Agent.get(:store, fn map -> Map.get(map, key) end)
  end

  def start_timer(name) do
	time = System.monotonic_time()

	timer = get_value(name)
	case hd(timer) do
	  {_, _} ->
		store_value(name, [time | timer])

	  start when is_integer(start) ->
		nil
	end
  end
end
