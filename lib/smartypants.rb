# Based on:
# https://github.com/jrbeck/neuron and
# https://medium.com/technology-invention-and-more/how-to-build-a-simple-neural-network-in-9-lines-of-python-code-cc8f23647ca1

require 'smartypants/version'
require 'smartypants/layer'
require 'smartypants/net'
require 'smartypants/neuron'
require 'smartypants/net'

module Smartypants
  class Smarty
    def train
      smarty = Net.new([4, 2])
      smarty.train(1)
    end
  end
end
