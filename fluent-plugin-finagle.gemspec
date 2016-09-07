
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-finagle"
  spec.version       = "0.0.1"
  spec.authors       = ["Kai Sasaki"]
  spec.email         = ["lewuathe@me.com"]
  spec.summary       = %q{fluentd input plugin for Finagle metric}
  spec.description   = %q{fluentd input plugin for Finagle metric}
  spec.homepage      = "http://github.com/Lewuathe/fluent-plugin-finagle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "faraday"
  spec.add_runtime_dependency "yajl-ruby"
  spec.add_runtime_dependency "test-unit"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end