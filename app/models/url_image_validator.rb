class URLImageValidator 
  include HTTParty

  def self.valid?(url)
    begin
      response = HTTParty.get(url).code
      (200..299).include? response
    rescue
      false
    end
  end
end