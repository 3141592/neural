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
  values = []
 
  File.open('data/and.data').each do |line|
    data = line.gsub("\n","").split(",")
    data.map!(&:to_f)

    # To Test
    test = false
    if test
        weight_array = [0.5173013833385226, 0.33786365148702724, 0.7807028531589777]
        weight_vector = Vector.elements(weight_array)
        neuron1.weight_vector = weight_vector
        neuron1.test(data)
    else
        # To Train
        neuron1.train(data)
    end
  end
 
  puts neuron1.weight_vector
  create_graph_lx(neuron1.values)
  neuron1.save

end

main
