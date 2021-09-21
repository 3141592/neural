#
# Neural Network Layer
#
require 'yaml'
require 'pry'

class Layer
  attr_accessor :name, :neurons, :data_file, :mode, :function, :neuron_count, :output, :target, :results, :weights

  def initialize(data)
    @neurons = []
    @output = []
    @target = []
    @results = []
    @weights = []

    @name = data[:name]
    @data = data[:data_file]
    @mode = data[:mode]
    @function = data[:function]
    @neuron_count = data[:neuron_count]

  end

  def to_s
    self.instance_variables.each do |variable|
      print "#{variable}: "
      puts instance_variable_get variable
    end
  end

  def add_neuron
    neuron = Neuron.new(
      name: @data,
    )
    @neurons << neuron
  end

  def train()
    values = []
    target = [] 
    File.open("data/#{@data}").each do |line|
      neurons.each do |neuron|
        data = line.gsub("\n","").split(",")
        data.map!(&:to_f)

        target << data.last
        # To Test
        if @mode.eql? "test"
            puts "Running test..."
            weight_array = [1.4986656343417852, 0.7381933044670312, 0.8103277910526923, 0.6708803149562411]
            weight_vector = Vector.elements(weight_array)
            neuron.weight_vector = weight_vector
            neuron.test(data)
        else
            puts "Training..."
            # To Train
            neuron.train(data)
        end

        #print "Target: #{target}\n"
        @target = neuron.target
        #print "Results: #{neuron.final}\n"
        @results = neuron.results

        #puts neuron.weight_vector
        @weights = neuron.weight_vector
        @output << neuron.output

        File.open("store/#{neuron.name}", 'a') { |f| f.puts(neuron.weight_vector) }

        #create_graph_lx(neuron.name, neuron.values) unless test
      end # neurons.each
    end # file.each

  end
end
