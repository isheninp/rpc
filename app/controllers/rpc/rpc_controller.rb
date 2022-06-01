module Rpc
  class RpcController < ActionController::API
    def execute
      
      res = ::Rpc::Router.call(props: params.permit!.to_h)

      render json: {
        status: res.status,
        data: res.data.as_json
      }

    end
  end
end