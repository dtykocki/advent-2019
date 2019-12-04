defmodule Advent2019.IntcodeTest do
  use ExUnit.Case
  doctest Advent2019.Intcode

  alias Advent2019.Intcode

  test "part 1" do
    assert Intcode.part_1() == 5_534_943
  end

  test "part 2" do
    assert Intcode.part_2() == 7603
  end
end
