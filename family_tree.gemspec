require_relative 'lib/family_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "family_tree"
  spec.version       = FamilyTree::VERSION
  spec.authors       = ["ken"]
  spec.email         = ["block24block@gmail.com"]

  spec.summary       = %q{Print classes family tree}
  spec.homepage      = "https://github.com/turnon/family_tree"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tree_graph", "~> 0.2.4"
  spec.add_dependency "tree_html", "~> 0.1.10"
end
