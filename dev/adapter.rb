
class API
  def self.get(url, params = nil)
    request = HTTP.headers(:accept => "application/json")
                  .get(url).to_s
    JSON.parse(request)
  end
end
