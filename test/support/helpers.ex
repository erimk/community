defmodule Community.Helpers do
  use CommunityWeb.ConnCase

  @spec graphql(Plug.Conn.t(), map(), map()) :: Plug.Conn.t()
  def graphql(conn, query, vars \\ nil) do
    post(conn, "/api", %{"query" => query, "variables" => vars})
  end
end
