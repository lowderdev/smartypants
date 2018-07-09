module Smartypants
  class Net
    attr_accessor :epoch, :layers, :output_layer, :training_inputs, :training_outputs

    def initialize(layer_sizes)
      @epoch = 0
      @training_inputs = [[0, 0, 1]] # [[0, 0, 1], [1, 1, 1], [1, 0, 1], [0, 1, 1]]
      @training_outputs = [[0]] # [[0], [1], [1], [0]]
      @layers = generate_layers(layer_sizes)
      @output_layer = Layer.new(@training_outputs.first.length, @layers.last.neurons.length)
      log_current_state
    end

    def train(epochs)
      epochs.times do |epoch|
        @epoch = epoch + 1
        @training_inputs.each_with_index do |training_input, i|
          propagate(training_input)
          log_current_state
          back_propagate(@training_outputs[i])
          # update_weights(training_input)

          # error = @training_outputs - output

          # Back propogation:
          # Inputs which are zero do not cause changes to the weights
          # adjustment = @training_inputs.transpose * (error * sigmoid_derivative(output))
          # @weights += adjustment
        end
      end
    end

    private
      def log_current_state
        puts
        puts "====== Epoch #{@epoch} ======"
        @layers.each_with_index do |layer, i|
          puts "Layer #{i}"
          layer.log_current_state
        end
        puts
        puts 'Output Layer'
        @output_layer.log_current_state
      end

      def generate_layers(layer_sizes)
        input_size = @training_inputs.first.length
        layer_sizes.reduce([]) do |layers, size|
          layers << Layer.new(size, input_size)
          input_size = size
          layers
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

      # def update_weights(training_input)
      #   inputs = training_input
      #   [*@layers, @output_layer].each do |layer|
      #     layer.neurons.each do |neuron|
      #       inputs.each_with_index do |input, index|
      #         neuron.weights[index] += @learning_rate * neuron.delta * input
      #       end
      #       neuron.weights[-1] += @learning_rate * neuron.delta
      #     end

      # #     # for next round
      #     inputs = layer.neurons.map(&:value)
      #   end
      # end
  end
end
