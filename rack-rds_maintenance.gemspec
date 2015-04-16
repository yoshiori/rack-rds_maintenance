# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "rack-rds_maintenance"
  spec.version       = 0.1
  spec.authors       = ["Yoshiori SHOJI"]
  spec.email         = ["yoshiori@gmail.com"]

  spec.summary       = %q{Rack::RdsMaintenance is a receive Amazon RDS maintenance notification interface for rack applications.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/yoshiori/rack-rds_maintenance"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "pry-byebug"
end
