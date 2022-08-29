# RPC-server
class Rpc::Router
  include Interactor

  # Allowed methods mapping
  # RPC_METHODS={
  #   "TaxonomyCreate" => "Taxonomy::Create",
  #   "TaxonCreateOrUpdate" => "Taxon::CreateOrUpdate",
  #   "ImportCreate" => "Import::Create"
  # }.freeze
  
  def call

    method = RPC_METHODS[context.props[:method]]
    
    if method
      response = method.constantize.send(:call, context.props[:params][0])
      context.data = response.result
      context.status = response.success? ? 'success' : 'error'
    else
      context.status = 'error'
      context.data = 'wrong method'
      context.fail!
    end

  rescue => e
    
    context.status = 'error'
    context.data = e.message
    context.fail!
 
  end

end
