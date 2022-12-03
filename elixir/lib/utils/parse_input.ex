defmodule Advent.Utils.ParseInput do
  def run!(day) do
    File.read!("inputs/day-#{day}-input.txt")
    |> String.split("\n")
  end
end
