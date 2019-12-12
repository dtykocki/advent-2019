defmodule Advent2019.Day04 do
  def part_1 do
    156218..652527
    |> Enum.map(&Integer.to_string/1)
    |> Enum.filter(&increasing/1)
    |> Enum.filter(&contains_double/1)
    |> Enum.count()
  end

  def part_2 do
    156218..652527
    |> Enum.map(&Integer.to_string/1)
    |> Enum.filter(&increasing/1)
    |> Enum.filter(&exactly_double/1)
    |> Enum.count()
  end

  defp increasing(string) do
    items = String.graphemes(string)
    items == Enum.sort(items)
  end

  defp contains_double(<<>>), do: false
  defp contains_double(<<c, c, _rest::binary>>), do: true
  defp contains_double(<<_c, rest::binary>>), do: contains_double(rest)

  defp exactly_double(<<>>), do: false
  defp exactly_double(<<c, c, c, rest::binary>>), do: exactly_double(String.trim_leading(rest, <<c>>))
  defp exactly_double(<<c, c, _rest::binary>>), do: true
  defp exactly_double(<<_, rest::binary>>), do: exactly_double(rest)
end
