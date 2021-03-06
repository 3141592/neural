require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  

  test = ARGV[0] == "test"
  function = ARGV[1]

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
    if test
        puts "Running test..."
        weight_array = [0.40903175365587763, 0.25346103501725536, 0.5818914448261708]
        weight_vector = Vector.elements(weight_array)
        neuron1.weight_vector = weight_vector
        neuron1.test(data)
    else
        puts "Training..."
        # To Train
        neuron1.train(data)
    end
  end
 
  puts neuron1.weight_vector
  create_graph_lx(neuron1.values)
  neuron1.save

end

main
