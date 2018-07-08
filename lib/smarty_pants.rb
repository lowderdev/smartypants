# Based on:
# https://github.com/jrbeck/neuron and
# https://medium.com/technology-invention-and-more/how-to-build-a-simple-neural-network-in-9-lines-of-python-code-cc8f23647ca1

require 'pp'

require 'smarty_pants/layer'
require 'smarty_pants/net'
require 'smarty_pants/neuron'
require 'smarty_pants/net'

module SmartyPants
  smarty = Net.new([4, 2])
  smarty.train(1)

  # training_inputs = Matrix[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
  # training_outputs = Matrix[[0, 1, 1, 0]].transpose

  # smarty.train(training_inputs, training_outputs, 10000)
  # smarty.train(1)

  # puts 'New synaptic weights after training: '
  # puts smarty.weights

  # Test the neural network with a new situation.
  # puts 'Considering new situation [1, 0, 0] -> ?: '
  # puts smarty.think(Matrix[[1, 0, 0]])
end
