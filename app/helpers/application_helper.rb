module ApplicationHelper
  def short_link(short_url)
    "#{request.protocol}#{request.host_with_port}/#{short_url.code}"
  end

end
