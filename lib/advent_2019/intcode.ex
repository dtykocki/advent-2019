defmodule Advent2019.Intcode do
  @moduledoc """
  Advent of Code Day 2: 1202 Program Alarm
  """

  @doc """
  ## Examples

  iex> Advent2019.Intcode.part_1()
  5_534_943

  """
  @spec part_1() :: pos_integer()
  def part_1 do
    parse()
    |> Map.put(1, 12)
    |> Map.put(2, 2)
    |> run_program()
    |> Map.get(0)
  end

  @doc """
  ## Examples

  iex> Advent2019.Intcode.part_2()
  7603
  """
  @spec part_2() :: pos_integer()
  def part_2 do
    sequence = for x <- 0..99, y <- 0..99, do: {x, y}

    parse()
    |> search(19_690_720, sequence)
    |> determine_result()
  end

  defp search(map, value, [{noun, verb} | remaining]) do
    new_map =
      map
      |> Map.put(1, noun)
      |> Map.put(2, verb)

    case run_program(new_map, 0) do
      %{0 => ^value} -> {noun, verb}
      _ -> search(map, value, remaining)
    end
  end

  defp determine_result({noun, verb}) do
    100 * noun + verb
  end

  defp parse do
    "day_2_input"
    |> Advent2019.input()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.into(Map.new(), fn {k, v} -> {v, k} end)
  end

  defp run_program(map, instruction_pointer \\ 0) do
    case Map.get(map, instruction_pointer) do
      1 ->
        map
        |> add(instruction_pointer)
        |> run_program(instruction_pointer + 4)

      2 ->
        map
        |> multiply(instruction_pointer)
        |> run_program(instruction_pointer + 4)

      99 ->
        map
    end
  end

  defp add(map, instruction_pointer) do
    {operand_1, operand_2, store_at} = read(map, instruction_pointer)
    Map.put(map, store_at, operand_1 + operand_2)
  end

  defp multiply(map, instruction_pointer) do
    {operand_1, operand_2, store_at} = read(map, instruction_pointer)
    Map.put(map, store_at, operand_1 * operand_2)
  end

  defp read(map, instruction_pointer) do
    pointer_1 = Map.get(map, instruction_pointer + 1)
    pointer_2 = Map.get(map, instruction_pointer + 2)
    store_at = Map.get(map, instruction_pointer + 3)
    {Map.get(map, pointer_1), Map.get(map, pointer_2), store_at}
  end
end
