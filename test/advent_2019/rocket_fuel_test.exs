defmodule Advent2019.RocketFuelTest do
  use ExUnit.Case
  doctest Advent2019.RocketFuel

  alias Advent2019.RocketFuel

  test "total rocket fuel from examples" do
    result =
      RocketFuel.total_fuel([
        "12\n",
        "14\n",
        "1969\n",
        "100756\n"
      ])

    assert result == 34_241
  end

  test "total rocket fuel from input file" do
    result = RocketFuel.total_fuel_from_file()

    assert result == 3_361_299
  end
end
