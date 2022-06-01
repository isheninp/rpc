require "rpc/version"
require "rpc/engine"

module Rpc

  # RPC - client side!
  class Server

    def initialize(url)
      @url=url
    end
    
    def method_missing(sym, *args, &block)
      
      # avoid pass params as array 
      # uncomment => you must delete [0] at server side
      # args = args.first if args.size == 1 && args.first.is_a?(Hash)
      
      response = Net::HTTP.post(
        URI(@url),
        {method: sym, params: args}.to_json,
        "Content-Type" => "application/json"
      )

      JSON.parse(response.body)
    
    rescue => e

      {
        status: 'error',
        data: e.message
      }
        
    end

  end

end
