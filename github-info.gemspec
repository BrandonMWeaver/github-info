lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "github-info/version"

Gem::Specification.new do |spec|
  spec.name          = "github-info"
  spec.version       = GithubInfo::VERSION
  spec.authors       = ["'Brandon Weaver'"]
  spec.email         = ["'a7xncob@gmail.com'"]
  
  spec.summary       = "This gem provides commands which are used to retrieve and output information from a github profile."
  spec.homepage      = "https://github.com/BrandonMWeaver/github-info"
  spec.license       = "MIT"
  
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
