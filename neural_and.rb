require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  

  function = ARGV[0]

  function = "sigmoid" if function.nil?

  neuron1 = Neuron.new(
    name: "And",
    transfer_parameter: 1 
  )

  dataFile = File.read("data/and.data") 
  
  File.open('data/and.data').each do |line|
    data = line.gsub("\n","").split(",")
    data.map!(&:to_f)
    neuron1.train(data)
  end
 
  puts neuron1.weight_vector
  neuron1.save
  create_graph_lx(values)

end

main
