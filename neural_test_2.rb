require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  

  function = ARGV[0]

  function = "sigmoid" if function.nil?

  # read test data
  file = File.open("data/iris.data")

  neuron1 = Neuron.new(
    name: "Add",
    vector_size: 4,
    transfer_parameter: 1 
  )
  
  values = []
  vector_size = 4
  file.each do |row|
    input = row.split(",")[0..3]
    next if input.size != vector_size
    input = input.flatten.collect { |i| i.to_f }
    neuron1.add_input(input[0..3])
    if function.eql? "transfer"
      values << neuron1.transfer
    elsif function.eql? "sigmoid"
      values << neuron1.sigmoid
    else
      values << neuron1.sigmoid
    end
  end
  puts neuron1.weight_vector
  neuron1.save
  create_graph_lx(values)

end

main
