class Quote < ActiveRecord::Base
  belongs_to :user

  def get_joke
    url = "https://icanhazdadjoke.com/"
    headers = { Accept: "application/json" }
    resp = APIAdapter.get(url, headers)
    self.text = resp["joke"]
  end

  def get_insult
    url = "https://insult.mattbas.org/api/insult.json"
    resp = APIAdapter.get(url)
    self.text = resp["insult"]
  end
end
