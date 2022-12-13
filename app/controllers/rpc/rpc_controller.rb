module Rpc
  class RpcController < ActionController::API
    
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with :name => RPC_USER, :password => RPC_PASSWORD

    def execute
      
      res = ::Rpc::Router.call(props: params.permit!.to_h)

      render json: {
        status: res.status,
        data: res.data.as_json
      }

    end
  end
end