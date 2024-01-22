defmodule CommunityWeb.NewsResolverTest do
  use CommunityWeb.ConnCase, async: true

  import Community.NewsFixtures

  setup %{conn: conn} do
    conn = put_req_header(conn, "accept", "application/json")

    {:ok, conn: conn}
  end

  describe "all_links/3" do
    test "returns ok when valid data", %{conn: conn} do
      link = link_fixture()

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

      url = "http://npmjs.com/package/graphql-tools"
      description = "Best Tools!"

      query = """
      mutation {
        createLink(
          url: "#{url}",
          description: "#{description}",
        ) {
          id
          url
          description
        }
      }
      """

      conn = post(conn, "/api", %{"query" => query})

      #assert [subject] = json_response(conn, 200)["data"]["createLink"]
      subject = json_response(conn, 200)["data"]["createLink"]
      assert subject["url"] == url
      assert subject["description"] == description

    end
  end
end
