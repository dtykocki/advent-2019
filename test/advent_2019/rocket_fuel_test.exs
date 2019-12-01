defmodule Advent2019.RocketFuelTest do
  use ExUnit.Case
  doctest Advent2019.RocketFuel

  alias Advent2019.RocketFuel

  test "total rocket fuel from examples" do
    input = ["12", "14", "1969", "100756"]
    result = RocketFuel.total_fuel(input)

    assert result == 51_316
  end

  test "total rocket fuel from input file" do
    result = RocketFuel.total_fuel_from_file()

    assert result == 5_039_071
  end
end
