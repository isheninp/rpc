require_relative "lib/rpc/version"

Gem::Specification.new do |spec|
  spec.name        = "rpc"
  spec.version     = Rpc::VERSION
  spec.authors     = ["Pavel Ishenin"]
  spec.email       = ["isheninp@gmail.com"]
  spec.homepage    = "https://github.com/isheninp/rpc"
  spec.summary     = "RPC server and client"
  spec.description = "RPC server and client"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/isheninp/rpc"
  spec.metadata["changelog_uri"] = "https://github.com/isheninp/rpc"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0.0"
  spec.add_dependency "interactor", ">= 3.0"

end
