# Stolen from:
# https://github.com/jrbeck/neuron and
# https://medium.com/technology-invention-and-more/how-to-build-a-simple-neural-network-in-9-lines-of-python-code-cc8f23647ca1

class SmartyPants
  attr_accessor :layers, :output_layer, :training_inputs, :training_outputs

  def initialize(layer_sizes)
    @training_inputs = [[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
    @training_outputs = [0, 1, 1, 0]
    @layers = generate_layers(layer_sizes)
    @output_layer = Layer.new(@training_outputs.length, @layers.last.neurons.length)
  end

  def train(epochs)
    epochs.times do
      propogate(@training_inputs)
      back_propagate(@training_outputs)
      update_weights(training_input)

      # error = @training_outputs - output

      # Back propogation:
      # Inputs which are zero do not cause changes to the weights
      # adjustment = @training_inputs.transpose * (error * sigmoid_derivative(output))
      # @weights += adjustment
    end
  end

  private
    def generate_layers(layer_sizes)
      input_size = @training_inputs.first.length
      layer_sizes.reduce([]) do |layers, size|
        layers << Layer.new(size, input_size)
        input_size = size
      end
    end

    def propagate(input_vector)
      @layers.each { |layer| input_vector = layer.compute(input_vector) }
      @output_layer.compute(input_vector)
    end

    def back_propagate(expected_output)
      @output_layer.compute_output_layer_error_vector(expected_output)
      last_layer = @output_layer
      @layers.reverse_each do |layer|
        layer.compute_error_vector(last_layer)
        last_layer = layer
      end
    end

    def update_weights(training_input)
      inputs = training_input
      [*@layers, @output_layer].each do |layer|
        layer.neurons.each do |neuron|
          inputs.each_with_index do |input, index|
            neuron.weights[index] += @learning_rate * neuron.delta * input
          end
          neuron.weights[-1] += @learning_rate * neuron.delta
        end

        # for next round
        inputs = layer.neurons.map(&:value)
      end
    end
end

smarty = SmartyPants.new

puts 'Random starting synaptic weights: '
puts smarty.weights

# training_inputs = Matrix[[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
# training_outputs = Matrix[[0, 1, 1, 0]].transpose

# smarty.train(training_inputs, training_outputs, 10000)
smarty.train(1)

puts 'New synaptic weights after training: '
puts smarty.weights

# Test the neural network with a new situation.
puts 'Considering new situation [1, 0, 0] -> ?: '
puts smarty.think(Matrix[[1, 0, 0]])
