# Rpc

RPC server and client for communication between applications

## Usage

Server side:

```
# allowed rpc-methods 
# config/initializers/rpc.rb
RPC_METHODS={
  "TaxonomyCreate" => "Taxonomy::Create",
  "TaxonCreateOrUpdate" => "Taxon::CreateOrUpdate",
  "ImportCreate" => "Import::Create"
}.freeze

```
Put your business logic into interactors

```
# interactors
class Import::Create
  include Interactor

  def call
    # use context.props as interactor parameters
    .... your code here
    context.result = product
  rescue => e
    context.fail!
  end
end
```

Client side:
```
# config/routes.rb
mount Rpc::Engine => '/', as: 'rpc'

# config/initializers/rpc.rb
# set up RPC servers
::Pim = ::Rpc::Server.new("http://pim:3000/rpc")
::Commerce = Rpc::Server.new("http://commerce:3000/rpc")

# somewhere in your app
# call to RPC-server
result = Pim.ImportCreate(props: product_data)
puts result.status # => 'success' / 'error'
puts result.data # => json-response data
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "rpc", github: 'isheninp/rpc'
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
