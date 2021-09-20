require 'matrix'
require_relative 'Neuron'
require_relative 'Graph'
require 'pry'

def main  
  data = ARGV[0]
  test = ARGV[1] == "test"
  function = ARGV[2]

  function = "sigmoid" if function.nil?

  neuron1 = Neuron.new(
    name: data,
    transfer_parameter: 1 
  )

  dataFile = File.read("data/and.data") 
  values = []
  target = [] 
  File.open("data/#{data}").each do |line|
    data = line.gsub("\n","").split(",")
    data.map!(&:to_f)

    target << data.last
    # To Test
    if test
        puts "Running test..."
        weight_array = [1.4986656343417852, 0.7381933044670312, 0.8103277910526923, 0.6708803149562411]
        weight_vector = Vector.elements(weight_array)
        neuron1.weight_vector = weight_vector
        neuron1.test(data)
    else
        puts "Training..."
        # To Train
        neuron1.train(data)
    end
  end

  print "Target: #{target}\n"
  print "Results: #{neuron1.final}\n"

  puts neuron1.weight_vector
  File.open("store/#{neuron1.name}", 'a') { |f| f.puts(neuron1.weight_vector) }

  create_graph_lx(neuron1.name, neuron1.values) unless test
  #neuron1.save

end

main
