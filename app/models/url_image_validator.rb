class URLImageValidator 
  include HTTParty

  def self.valid?(url)
    begin
      response = HTTParty.get(url).code
      (200..299).include? response.code
    rescue
      false
    end
  end
end