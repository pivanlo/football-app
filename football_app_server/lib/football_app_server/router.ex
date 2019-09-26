defmodule FootballAppServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/check" do
    send_resp(conn, 200, "ok")
  end

  get "/api/leagues" do
    %{"type" => type} = get_query_params(conn)

    case type do
      "protobuf" ->
        leagues = FootballAppServer.Queries.get_leagues() |> Protobufs.LeaguesProtobuf.to_protobuf()
        render_protobuf(conn, leagues)

      "json" ->
        leagues = FootballAppServer.Queries.get_leagues() |> Poison.encode!
        render_json(conn, leagues)

      _ ->
        send_resp(conn, 400, "400 Bad Request")
    end
  end

  get "/api/matches" do
    params = get_query_params(conn)

    try do
      %{"div" => _, "season" => _, "type" => _} = params
    rescue
      MatchError -> conn |> send_resp(400, "400 Bad Request") |> halt()
    else
      _ ->
        %{"div" => division, "season" => season, "type" => type} = params

        case type do
          "protobuf" ->
            matches = FootballAppServer.Queries.get_matches(division, season) |> Protobufs.LeaguesProtobuf.to_protobuf()
            render_protobuf(conn, matches)

          "json" ->
            matches = FootballAppServer.Queries.get_matches(division, season) |> Poison.encode!
            render_json(conn, matches)

          _ ->
            send_resp(conn, 400, "400 Bad Request")
        end
    end
  end

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end

  @doc """
  Helper function that sends a protobuf response.
  """
  def render_protobuf(conn, data) do
    conn
    |> put_resp_content_type("application/octet-stream")
    |> send_resp(200, data)
  end

  @doc """
  Helper function that sends a json response.
  """
  def render_json(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end

  @doc """
  Helper function that gets the query parameters from the query string.
  """
  def get_query_params(conn) do
    params = Plug.Conn.Query.decode(conn.query_string)

    # The 'type' parameter sets the format of the response. It defaults to 'json'.
    if Map.has_key?(params, "type") do
      params
    else
      Map.put(params, "type", "json")
    end
  end
end
