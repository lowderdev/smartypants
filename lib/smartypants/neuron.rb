module Smartypants
  class Neuron
    attr_accessor :delta, :value, :weights, :zed

    def initialize(input_size)
      @delta, @value, @weights, @zed = 0
      @weights = Array.new(input_size) { rand }
    end

    def compute(input_vector)
      if input_vector.length != @weights.length
        raise %(
          Input vector size does not equal number of weights!
          Invalid input_vector size: #{input_vector.length}
          Number of weights: #{@weights.length}
        )
      end

      @zed = dot(input_vector, @weights)
      @value = activate(@zed)
    end

    def compute_delta(error)
      @delta = error * activation_derivative(@value)
    end

    def log_current_state
      puts(weights: @weights, value: @value, zed: zed, delta: @delta)
    end

    private
      def dot(vector_a, vector_b)
        vector_a.each_with_index.reduce(0) do |sum, (element, index)|
          sum + vector_b[index] * element
        end
      end

      def activate(zed)
        # sigmoid
        1.0 / (1.0 + Math.exp(-zed))
      end

      def activation_derivative(value)
        # sigmoid derivative
        value * (1.0 - value)
      end
  end
end
