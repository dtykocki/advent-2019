defmodule Advent2019 do
  @moduledoc """
  Helper functions that have no other place to live.
  """

  @spec input(String.t()) :: String.t()
  def input(day) do
    :advent_2019
    |> :code.priv_dir()
    |> Path.join(day)
    |> File.read!()
  end
end
