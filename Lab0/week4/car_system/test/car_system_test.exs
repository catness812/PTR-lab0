defmodule CarSystemTest do
  use ExUnit.Case
  doctest CarSystem

  test "greets the world" do
    assert CarSystem.hello() == :world
  end
end
