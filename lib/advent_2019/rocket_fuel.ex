defmodule Advent2019.RocketFuel do
  @moduledoc """
  Advent of Code Day 1: The Tyranny of the Rocket Equation
  """

  @doc """
  Returns the sum of the fuel requirements for all of
  the modules from an input file.

  ## Examples

    iex> Advent2019.RocketFuel.total_fuel_from_file()
    5_039_071

  """
  @spec total_fuel_from_file() :: pos_integer()
  def total_fuel_from_file do
    :advent_2019
    |> :code.priv_dir()
    |> Path.join("day_1_input.txt")
    |> File.read!()
    |> String.split("\n", trim: true)
    |> total_fuel()
  end

  @doc """
  Returns the sum of the fuel requirements for a given list
  of strings.

  ## Examples

    iex> Advent2019.RocketFuel.total_fuel(["12", "14", "1969", "100756"])
    51_316

  """
  @spec total_fuel(Enum.t()) :: pos_integer()
  def total_fuel(input) do
    input
    |> Enum.map(fn item -> String.to_integer(item) end)
    |> Enum.map(fn item -> calculate_fuel(item) end)
    |> Enum.sum()
  end

  defp calculate_fuel(item) do
    item
    |> fuel()
    |> calculate_fuel(0)
  end

  defp calculate_fuel(item, acc) when item > 0 do
    item
    |> fuel()
    |> calculate_fuel(acc + item)
  end

  defp calculate_fuel(_, acc) do
    acc
  end

  defp fuel(item) do
    div(item, 3) - 2
  end
end
