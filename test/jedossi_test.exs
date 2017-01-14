defmodule JedossiTest do
  use ExUnit.Case
  doctest Jedossi
  import Jedossi

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
end
