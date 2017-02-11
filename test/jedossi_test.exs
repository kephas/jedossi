defmodule JedossiTest do
  use ExUnit.Case
  doctest Jedossi
  import Jedossi
  import Enum

  test "store/get" do
	create_store()
	store_value(:foo, :bar)
	assert :bar == get_value(:foo)
  end

  test "start" do
	create_store()
	start_timer(:foo)

	old = get_value(:foo)
	assert is_list(old)

	start_timer(:foo)
	assert old == get_value(:foo)
  end

  test "stop" do
	create_store()

	stop_timer(:foo)
	assert [] == get_value(:foo)

	start_timer(:foo)
	stop_timer(:foo)

	assert 1 == length(get_value(:foo))
  end

  test "start_all" do
	create_store()

	start_all()
	assert get_all_keys == []

	stop_timer(:foo)
	stop_timer(:bar)
	stop_timer(:baz)

	start_all()

	timers =  get_all_values()
	lengths = map(timers, fn timer -> length(timer) end)
	assert length(filter(lengths, fn ln -> ln == 1 end)) == 3

	assert reject(get_all_values, fn x -> case x do
											[] -> false
											[head | _ ] -> is_integer(head)
										  end
	                              end) == []
  end

  test "stop_all" do
	create_store()

	start_timer(:foo)
	start_timer(:bar)
	start_timer(:baz)

	stop_all()

	timers =  get_all_values()
	assert reject(map(timers, &length(&1)), fn ln -> ln == 1 end) == []
	assert reject(timers, &is_tuple(hd(&1))) == []
  end
end
