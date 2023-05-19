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
      response = method.constantize.send(:call, context.props[:params])
      context.data = response.result
      context.status = response.success? ? 'success' : 'error'
      if context.status == 'error'
        context.error_message = response.error_message
        context.error_code = response.error_code
        context.error_id = response.error_id
      end
    else
      context.status = 'error'
      context.data = 'wrong method'
      context.error_message = 'wrong method'
      context.error_code = 400
      context.error_id = 400
    end

  rescue => e

    context.status = 'error'
    context.data = e.message
    context.error_message = e.message
    context.error_code = 500
    context.error_id = 500
    context.fail!
 
  end

end
