defmodule Community.Helpers do
  use CommunityWeb.ConnCase

  # def graphql(conn, query) do
  #   conn
  #   |> post("/api", %{
  #     "query" => query
  #   })
  # end

  # def graphql(conn, query, args) do
  #   conn
  #   |> post("/api", %{
  #     "query" => query,
  #     "variables" => args
  #   })
  # end
  # def graphql(conn, query), do: post(conn, "/api", %{"query" => query})
  # def graphql(conn, query, vars), do: post(conn, "/api", %{"query" => query, "variables" => vars})
  @spec graphql(Plug.Conn.t(), map(), map()) :: Plug.Conn.t()
  def graphql(conn, query, vars \\ nil) do
    post(conn, "/api", %{"query" => query, "variables" => vars})
  end
end
