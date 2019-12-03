defmodule Advent2019.Intcode do
  @moduledoc """
  Advent of Code Day 2: 1202 Program Alarm
  """

  @doc """
  ## Examples

  iex> Advent2019.Intcode.compute_from_file()
  5_534_943

  """
  @spec compute_from_file() :: pos_integer()
  def compute_from_file do
    "day_2_input"
    |> Advent2019.input()
    |> parse()
    |> reset()
    |> run()
    |> hd()
  end

  def another_thing do
    {noun, verb} =
      "day_2_input"
      |> Advent2019.input()
      |> parse()
      |> find_error_code(19690720)

    100 * noun + verb
  end

  @doc """
  ## Examples

  iex> Advent2019.Intcode.compute("2,4,4,5,99,0")
  [2, 4, 4, 5, 99, 9801]

  """
  @spec compute(String.t()) :: Enum.t()
  def compute(program) do
    program
    |> parse()
    |> run()
  end

  defp parse(program) do
    program
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp reset(program, noun \\ 12, verb \\ 2) do
    program
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end

  defp find_error_code(program, error_code) do
    for noun <- 0..99, verb <- 0..99 do {noun, verb} end
    |> Enum.find(fn {noun, verb} ->
      result =
        program
        |> reset(noun, verb)
        |> run()
        |> hd()

      result == error_code
    end)
  end

  defp run(program, instruction_pointer \\ 0) do
    operation = Enum.at(program, 0 + instruction_pointer)
    first_operand = Enum.at(program, 1 + instruction_pointer)
    second_operand = Enum.at(program, 2 + instruction_pointer)
    store_at = Enum.at(program, 3 + instruction_pointer)

    case operation do
      1 ->
        result = Enum.at(program, first_operand) + Enum.at(program, second_operand)
        new_program = List.replace_at(program, store_at, result)
        run(new_program, 4 + instruction_pointer)

      2 ->
        result = Enum.at(program, first_operand) * Enum.at(program, second_operand)
        new_program = List.replace_at(program, store_at, result)
        run(new_program, 4 + instruction_pointer)

      99 ->
        program
    end
  end
end
