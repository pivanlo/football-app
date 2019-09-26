defmodule Protobufs.LeaguesProtobuf do
  @moduledoc """
  The Leagues Protobuf module.
  """

  use Protobuf, from: Path.expand("../../../proto/leagues.proto", __DIR__)

  @doc """
  Creates a Leagues struct.

  ## Examples

      iex> Protobufs.LeaguesProtobuf.Leagues.new([])
      %Protobufs.LeaguesProtobuf.Leagues{leagues: []}

  """
  def new(leagues) do
    Enum.reduce(leagues, Protobufs.LeaguesProtobuf.Leagues.new(), fn league, map ->
      append(map, league)
    end)
  end

  @doc """
  Appends a league to the given Leagues struct.

  ## Examples

      iex> Protobufs.LeaguesProtobuf.Leagues.new([]) |> Protobufs.LeaguesProtobuf.append(%{div: "foo", season: "bar"})
      %Protobufs.LeaguesProtobuf.Leagues{
        leagues: [
          %Protobufs.LeaguesProtobuf.Leagues.League{div: "foo", season: "bar"}
        ]
      }

  """
  def append(map, %{div: division, season: season}) do
    league = Protobufs.LeaguesProtobuf.Leagues.League.new(div: division, season: season)
    %{map | leagues: map.leagues ++ [league]}
  end

  def to_protobuf(map) do
    map
    |> new()
    |> Protobufs.LeaguesProtobuf.Leagues.encode()
  end
end
