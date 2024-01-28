defmodule Community.Factory do
  use ExMachina.Ecto, repo: Community.Repo

  def link_factory do
    %Community.News.Link{
      description: "some description",
      url: "some url"
    }
  end
end
