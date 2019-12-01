defmodule Advent2019.RocketFuel do
  @moduledoc """
  Advent of Code Day 1: The Tyranny of the Rocket Equation
  """

  @doc """
  Returns the sum of the fuel requirements for all of
  the modules from an input file.

  ## Examples

    iex> Advent2019.RocketFuel.total_fuel_from_file()
    3_361_299

  """
  @spec total_fuel_from_file() :: pos_integer()
  def total_fuel_from_file do
    :advent_2019
    |> :code.priv_dir()
    |> Path.join("day_1_input.txt")
    |> File.stream!([], :line)
    |> total_fuel()
  end

  @doc """
  Returns the sum of the fuel requirements for a given list
  of strings.

  ## Examples

    iex> Advent2019.RocketFuel.total_fuel(["12","14","1969","100756"])
    34_241

  """
  @spec total_fuel(Enum.t()) :: pos_integer()
  def total_fuel(input_stream) do
    input_stream
    |> Stream.map(&parse_line/1)
    |> Enum.reduce(0, &reducer/2)
  end

  defp reducer(value, acc) do
    acc + (div(value, 3) - 2)
  end

  defp parse_line(line) do
    {integer, _} = Integer.parse(line)
    integer
  end
end
