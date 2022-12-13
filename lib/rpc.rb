require "rpc/version"
require "rpc/engine"
require 'net/http'

module Rpc

  # RPC - client side!
  class Server

    def initialize(url, authorization='dev:000')
      @url=url
      @authorization = "Basic #{Base64.strict_encode64(authorization)}"
    end
    
    def method_missing(sym, *args, &block)
  
      response = Net::HTTP.post(
        URI(@url),
        {method: sym, params: args.first}.to_json,
        "Content-Type" => "application/json",
        "Authorization" => @authorization
      )
  
      JSON.parse(response.body)        
      
    rescue => e

      {
        status: 'error',
        data: "#{response&.code} #{response&.msg} #{e.message}".strip
      }
        
    end

  end

end
