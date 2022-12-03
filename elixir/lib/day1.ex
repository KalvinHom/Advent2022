defmodule Advent.Day1 do
  alias Advent.Utils.ParseInput
  @day 1

  def part1_run!() do
    @day
    |> ParseInput.run!()
    |> get_calorie_totals()
    |> Enum.at(0)
  end

  def part2_run!() do
    @day
    |> ParseInput.run!()
    |> get_calorie_totals()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp get_calorie_totals(calorie_list) do
    result =
      calorie_list
      |> Enum.reduce({[], 0}, fn row, acc ->
        {calories, current_total} = acc

        case row do
          "" ->
            {[current_total | calories], 0}

          calorie ->
            total =
              calorie
              |> String.to_integer()
              |> Kernel.+(current_total)

            {calories, total}
        end
      end)

    {calories, _} = result
    Enum.sort(calories, :desc)
  end
end
