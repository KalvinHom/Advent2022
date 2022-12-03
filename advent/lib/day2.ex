defmodule Advent.Day2 do
  alias Advent.Utils.ParseInput
  @day 2
  @hand_score %{"X" => 1, "Y" => 2, "Z" => 3}
  @hand_map %{"A" => "X", "B" => "Y", "C" => "Z"}
  @result_map %{
    "X" => %{win: "Y", lose: "Z"},
    "Y" => %{win: "Z", lose: "X"},
    "Z" => %{win: "X", lose: "Y"}
  }

  def part1_run!() do
    @day
    |> ParseInput.run!()
    |> Enum.map(fn round ->
      [opponent, hand] = String.split(round)
      get_round_score(opponent, hand)
    end)
    |> Enum.sum()
  end

  def part2_run!() do
    @day
    |> ParseInput.run!()
    |> Enum.map(fn round ->
      [opponent, result] = String.split(round)

      hand =
        @hand_map
        |> Map.get(opponent)
        |> get_played_hand(result)

      get_round_score(opponent, hand)
    end)
    |> Enum.sum()
  end

  defp get_round_score(opponent, hand) do
    result_score =
      @hand_map
      |> Map.get(opponent)
      |> compare_hand(hand)

    hand_score = Map.get(@hand_score, hand)

    result_score + hand_score
  end

  defp get_played_hand(opponent, "Y"), do: opponent

  defp get_played_hand(opponent, "X") do
    @result_map
    |> Map.get(opponent)
    |> Map.get(:lose)
  end

  defp get_played_hand(opponent, "Z") do
    @result_map
    |> Map.get(opponent)
    |> Map.get(:win)
  end

  defp compare_hand(opponent, hand) when opponent == hand, do: 3

  defp compare_hand(opponent, hand) do
    case Map.get(@result_map, opponent) do
      %{win: ^hand} -> 6
      _ -> 0
    end
  end
end
