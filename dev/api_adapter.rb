class APIAdapter
  def self.get(url, params = nil)
    request = HTTP.headers(params)
                  .get(url).to_s
    JSON.parse(request)
  end
end
