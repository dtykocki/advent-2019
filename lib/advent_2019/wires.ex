defmodule Advent2019.Wires do
  @doc """
  # Examples

  iex> Advent2019.Wires.part_1()
  2427
  """
  @spec part_1() :: pos_integer()
  def part_1 do
    input_file()
    |> parse()
    |> generate_wires()
    |> intersection()
    |> distance()
  end

  @doc """
  # Examples

  iex> Advent2019.Wires.part_2()
  27_890
  """
  @spec part_1() :: pos_integer()
  def part_2 do
    [wires1, wires2] =
      input_file()
      |> parse()
      |> generate_wires()

    intersections = intersection([wires1, wires2])
    steps_1 = steps(wires1, intersections)
    steps_2 = steps(wires2, intersections)

    Enum.zip(steps_1, steps_2)
    |> Enum.map(fn {a, b} -> a + b end)
    |> Enum.min()
  end

  defp input_file do
    :advent_2019
    |> :code.priv_dir()
    |> Path.join("day_3_input.txt")
    |> File.read!()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], &input_reducer/2)
    |> Enum.reverse()
  end

  defp generate_wires(cables) do
    Enum.map(cables, &generate_points/1)
  end

  defp intersection([wire1, wire2]) do
    set_1 = MapSet.new(wire1)
    set_2 = MapSet.new(wire2)
    MapSet.intersection(set_1, set_2)
  end

  defp distance(set) do
    set
    |> Enum.to_list()
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.sort()
    |> Enum.at(0)
  end

  defp steps(wire, intersections) do
    Enum.reduce(intersections, [], fn point, crosses ->
      result = Enum.reduce_while(wire, 1, fn item, acc ->
        case item == point do
          true ->
            {:halt, acc}
          false ->
            {:cont, acc + 1}
        end
      end)
      [result | crosses]
    end)
  end

  defp generate_points(list) do
    {_, set} =
      Enum.reduce(list, {{0, 0}, []}, fn {direction, distance}, {point, set} ->
        Enum.reduce(1..distance, {point, set}, fn _, {point, set} ->
          next_point = move(direction, point)
          {next_point, [next_point | set]}
        end)
      end)
    set |> Enum.reverse()
  end

  defp move(:up, {x, y}), do: {x, y + 1}
  defp move(:down, {x, y}), do: {x, y - 1}
  defp move(:left, {x, y}), do: {x - 1, y}
  defp move(:right, {x, y}), do: {x + 1, y}

  defp parse_position(<<"U", rest::binary>>), do: {:up, String.to_integer(rest)}
  defp parse_position(<<"D", rest::binary>>), do: {:down, String.to_integer(rest)}
  defp parse_position(<<"L", rest::binary>>), do: {:left, String.to_integer(rest)}
  defp parse_position(<<"R", rest::binary>>), do: {:right, String.to_integer(rest)}

  defp input_reducer(list, acc) do
    positions =
      list
      |> String.split(",")
      |> Enum.map(&parse_position/1)

    [positions | acc]
  end
end
