defmodule JedossiTest do
  use ExUnit.Case
  doctest Jedossi

  test "store/get" do
	Jedossi.create_store()
	Jedossi.store_value(:foo, :bar)
	assert :bar == Jedossi.get_value(:foo)
  end
end
