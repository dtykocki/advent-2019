defmodule Advent2019.IntcodeTest do
  use ExUnit.Case
  doctest Advent2019.Intcode

  alias Advent2019.Intcode

  test "with provided examples" do
    assert Intcode.compute("1,0,0,0,99") == [2, 0, 0, 0, 99]
    assert Intcode.compute("2,3,0,3,99") == [2, 3, 0, 6, 99]
    assert Intcode.compute("2,4,4,5,99,0") == [2, 4, 4, 5, 99, 9801]
    assert Intcode.compute("1,1,1,4,99,5,6,0,99") == [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end

  test "restore gravity assist program" do
    assert Intcode.compute_from_file() == 5_534_943
  end
end
