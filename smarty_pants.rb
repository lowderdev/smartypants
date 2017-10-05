# Stolen and translated to Ruby from:
# https://medium.com/technology-invention-and-more/how-to-build-a-simple-neural-network-in-9-lines-of-python-code-cc8f23647ca1

require 'matrix'

class SmartyPants
  attr_accessor :training_set_inputs, :training_set_outputs, :weights

  def initialize
    @training_set_inputs = Matrix[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
    @training_set_outputs = Matrix[[0, 1, 1, 0]].transpose
    @weights = Matrix.build(3, 1) { rand(-1.0..1.0) }
  end

  def train(training_iterations)
    training_iterations.times do
      # Forward: (single neuron)
      output = evaluate(@training_set_inputs)
      puts
      puts 'OUTPUT:'
      puts output
      puts
      error = @training_set_outputs - output
      puts 'ERROR:'
      puts error
      puts

      puts 'sigmoid_derivative(output): '
      puts sigmoid_derivative(output)
      puts

      puts 'error * sigmoid_derivative(output): '
      puts error * sigmoid_derivative(output)



      # Back propogation:
      # Inputs which are zero do not cause changes to the weights
      adjustment = @training_set_inputs.transpose * (error * sigmoid_derivative(output))
      @weights += adjustment
    end
  end

  def evaluate(inputs)
    sigmoid(inputs * @weights)
  end

  private
    def sigmoid(matrix)
      # python: 1 / (1 + exp(-matrix))
      matrix.map do |element|
        1 / (1 + (Math::E**-element))
      end
    end

    def sigmoid_derivative(matrix)
      matrix.map do |element|
        element * (1 - element)
      end
    end
end

smarty = SmartyPants.new

puts 'Random starting synaptic weights: '
puts smarty.weights

# training_set_inputs = Matrix[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
# training_set_outputs = Matrix[[0, 1, 1, 0]].transpose

# smarty.train(training_set_inputs, training_set_outputs, 10000)
smarty.train(1)

puts 'New synaptic weights after training: '
puts smarty.weights

# Test the neural network with a new situation.
puts 'Considering new situation [1, 0, 0] -> ?: '
puts smarty.think(Matrix[[1, 0, 0]])
