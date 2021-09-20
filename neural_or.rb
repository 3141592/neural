require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  

  test = ARGV[0] == "test"
  function = ARGV[1]

  function = "sigmoid" if function.nil?

  neuron1 = Neuron.new(
    name: "Or",
    transfer_parameter: 1 
  )

  dataFile = File.read("data/and.data") 
  values = []
 
  File.open('data/or.data').each do |line|
    data = line.gsub("\n","").split(",")
    data.map!(&:to_f)

    # To Test
    if test
        weight_array = [0.5280792893951307, 0.2578971742250856, 0.17185775067809468]
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
