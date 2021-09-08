require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  

  function = ARGV[0]

  function = "sigmoid" if function.nil?

  # read test data
  file = File.open("data/and.data")

  neuron1 = Neuron.new(
    name: "And",
    vector_size: 4,
    training_data: "and.data",
    transfer_parameter: 1 
  )
 
  neuron1.train
 
  puts neuron1.weight_vector
  neuron1.save
  create_graph_lx(values)

end

main
