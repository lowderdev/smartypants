lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'SmartyPants'
  spec.version       = '0.1'
  spec.authors       = ['Logan Lowder']
  spec.email         = ['loganlowder@gmail.com']
  spec.summary       = 'A super basic neural net from scratch'
  spec.description   = 'I wanted to build a super simple NN from scratch to learn how NNs work.'
  spec.homepage      = 'https://github.com/lowderl/smarty_pants'
  spec.license       = 'MIT'

  spec.files         = ['lib/smarty_pants.rb']
  spec.executables   = ['bin/smarty_pants']
  spec.test_files    = ['tests/test_smarty_pants.rb']
  spec.require_paths = ['lib']
end
