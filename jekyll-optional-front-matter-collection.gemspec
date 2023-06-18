# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-optional-front-matter-collection"
  spec.version       = "0.1.0"
  spec.authors       = ["Sangwan Jeon"]
  spec.email         = ["commits@swjeon.kr"]
  spec.homepage      = "https://github.com/maxswjeon/jekyll-optional-front-matter-collection"
  spec.summary       = "A Jekyll plugin to make front matter optional for collection documents"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_data|_layouts|_includes|_sass|LICENSE|README|_config\.yml)!i) }
  spec.platform      = Gem::Platform::RUBY
  spec.require_paths = ["lib"]
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5"

  spec.add_runtime_dependency "jekyll", ">= 3.0", "< 5.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.45"
  spec.add_development_dependency "rubocop-rspec", "~> 2.22"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.13"
  spec.add_development_dependency "rubocop-performance", "~> 1.18"
end
