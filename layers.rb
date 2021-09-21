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
    data_file: "Autism-Adult-Data.csv",
    mode: "train",
    function: "sigmoid",
    neuron_count: 1,
  )

  layer1.add_neuron
  #layer1.add_neuron
  layer1.train
  print layer1.output
  puts layer1.target
  puts layer1.results
  puts layer1.weights


end

main
