defmodule CommunityWeb.NewsResolverTest do
  use CommunityWeb.ConnCase, async: true

  import Community.Factory

  setup %{conn: conn} do
    conn = put_req_header(conn, "accept", "application/json")

    {:ok, conn: conn}
  end

  describe "all_links/3" do
    test "returns ok when valid data", %{conn: conn} do
      link = insert(:link)

      query = """
      {
        allLinks {
          id
          url
          description
        }
      }
      """

      conn = post(conn, "/api", %{"query" => query})

      assert [subject] = json_response(conn, 200)["data"]["allLinks"]
      assert subject["id"] == "#{link.id}"
      assert subject["url"] == link.url
      assert subject["description"] == link.description
    end
  end

  describe "create_link/3" do
    test "returns ok when valid data", %{conn: conn} do
      params = params_for(:link)

      conn = graphql_create_link(conn, params)

      assert subject = json_response(conn, 200)["data"]["createLink"]
      assert subject["id"]
      assert subject["url"] == params.url
      assert subject["description"] == params.description
    end

    test "returns error when url is null", %{conn: conn} do
      params = params_for(:link) |> Map.merge(%{url: nil})

      conn = graphql_create_link(conn, params)

      assert [%{"message" => "could not create link"}] = json_response(conn, 200)["errors"]
    end
  end

  defp graphql_create_link(conn, params) do
    query = """
    mutation {
      createLink(
        url: "#{params.url}",
        description: "#{params.description}",
      ) {
        id
        url
        description
      }
    }
    """

    post(conn, "/api", %{"query" => query})
  end
end
