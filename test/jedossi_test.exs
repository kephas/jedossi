defmodule JedossiTest do
  use ExUnit.Case
  doctest Jedossi

  test "store/get" do
	Jedossi.create_store()
	Jedossi.store_value(:foo, :bar)
	assert :bar == Jedossi.get_value(:foo)
  end

  test "start" do
	Jedossi.create_store()
	Jedossi.start_timer(:foo)

	old = Jedossi.get_value(:foo)
	assert is_list(old)

	Jedossi.start_timer(:foo)
	assert old == Jedossi.get_value(:foo)
  end

  test "stop" do
	Jedossi.create_store()

	Jedossi.stop_timer(:foo)
	assert [] == Jedossi.get_value(:foo)

	Jedossi.start_timer(:foo)
	Jedossi.stop_timer(:foo)

	assert 1 == length(Jedossi.get_value(:foo))
  end
end
