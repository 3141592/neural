#
# Test Layer object
#
require_relative 'Layer'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main
  
  layer1 = Layer.new(
    name: "layer1",
    data_file: "and.data",
    mode: "train",
    function: "sigmoid",
    neuron_count: 1,
  )

  layer1.add_neuron
  layer1.train

  layer1.to_s

end

main
