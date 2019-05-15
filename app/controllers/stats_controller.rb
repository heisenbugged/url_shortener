class StatsController < ApplicationController
  def show
    @short_urls = ShortUrl.select("full_link, COUNT(full_link) as count")
                          .group("full_link")
                          .order("count desc")
                          .limit(10)
  end
end