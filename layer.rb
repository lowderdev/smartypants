class Layer
  attr_accessor :neurons

  def initialize(size, input_size)
    @neurons = Array.new(size) { Neuron.new(input_size) }
  end

  def compute(input_vector)
    @neurons.map { |neuron| neuron.compute(input_vector) }
  end

  def compute_output_layer_error_vector(expected_vector)
    @neurons.each_with_index.reduce([]) do |error_vector, (neuron, index)|
      error = expected_vector[index] - neuron.value
      neuron.compute_delta(error)
      error_vector << error
    end
  end

  def compute_error_vector(previous_layer)
    # Name something like back_prop? Or compute_layer_deltas?
    # Do we even need to return the error_vector?
    # I think we just need to calculate the deltas for neurons
    @neurons.each_with_index.reduce([]) do |error_vector, (neuron, index)|
      error = 0.0
      previous_layer.neurons.each do |previous_layer_neuron|
        error += previous_layer_neuron.weights[index] * previous_layer_neuron.delta
      end
      neuron.compute_delta(error)
      error_vector << error
    end
  end

  def compute_simple_error(expected_vector)
    @neurons.each_with_index.reduce([]) do |error_vector, (neuron, index)|
      error = expected_vector[index] - neuron.value
      error_vector << error
    end
  end
end
