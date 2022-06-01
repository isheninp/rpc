Rails.application.routes.draw do
  mount Rpc::Engine => "/rpc"
end
