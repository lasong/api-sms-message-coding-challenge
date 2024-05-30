class SmsSender
  class Response
    def success?
      true
    end
  end

  def self.send(_messages)
    Response.new
  end
end
