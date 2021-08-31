require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'

def main  

  neuron1 = Neuron.new(
    vector_size: 1,
    transfer_parameter: 1 
  )

  xvalues = [*1..100]
  yvalues = []

  xvalues.each do |i|
    neuron1.add_input_vector([Math.cos(i.to_f/10)])
  end
  puts neuron1.weight_vector
  puts neuron1.transfer
  create_graph_lxy(xvalues, yvalues)

end

main
