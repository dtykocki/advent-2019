defmodule Advent2019.Wires do
  def part_1 do
    input_file()
    |> parse()
    |> into_sets()
    |> intersection()
    |> distance()
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

  defp into_sets(cables) do
    Enum.map(cables, &into_set/1)
  end

  defp intersection([set_1, set_2]) do
    MapSet.intersection(set_1, set_2)
  end

  defp distance(set) do
    set
    |> Enum.to_list()
    |> Enum.map(fn {x,y} -> abs(x) + abs(y) end)
    |> Enum.sort()
    |> Enum.at(0)
  end

  defp into_set(list) do
    {_, set} = Enum.reduce(list, {{0,0}, MapSet.new()}, fn {direction, distance}, {point, set} ->
      Enum.reduce(1..distance, {point, set}, fn _, {point, set} ->
        next_point = move(direction, point)
        {next_point, MapSet.put(set, next_point)}
      end)
    end)
    set
  end

  defp move(:up,    {x, y}), do: {x, y + 1}
  defp move(:down,  {x, y}), do: {x, y - 1}
  defp move(:left,  {x, y}), do: {x - 1, y}
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
