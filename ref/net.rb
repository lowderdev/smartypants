class Neuron
  attr_accessor :sources, :value, :targets

  def initialize(sources, value, targets)
    @sources = sources
    @value = value
    @targets = targets
  end

  # def calc
  #   pulses = @sources.map(&:pulse)
  #   sum_of_synapses = pulses.reduce(0) { |sum, pulse| sum + pulse }
  #   activate(sum_of_synapses)
  # end

  # private
  #   def activate(n)
  #     1 / (1 + (Math::E ** -n))
  #   end
end

class Synapse
  attr_accessor :weight, :source, :target

  def initialize(weight, source, target)
    @weight = weight
    @source = source
    @target = target
  end

  # def pulse
  #   @source.value * @weight
  # end
end

class Layer
  attr_accessor :neurons

  def initialize(number_of_neurons)
    @neurons = Array.new(number_of_neurons) { rand }
  end

  private
    def dot(vector_a, vector_b)
      vector_a.each_with_index.reduce(0) { |sum, (element, index)| sum + vector_b[index] * element }
    end
end

class SynapseGroup
  attr_accessor :synapses

  def initialize(source_layer, target_layer)
    number_of_synapses = source_layer.length * target_layer.length
    @synapses = [].tap { |synapses| number_of_synapses.times { synapses << rand(0.0..1.0) } }
  end
end
