Rpc::Engine.routes.draw do
  post '/rpc' => 'rpc#execute',  format: :json
end
