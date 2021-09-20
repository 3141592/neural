# 
# A single artificial neuron.
#
require 'matrix'
require 'yaml'
require 'pry'

class Neuron
  attr_accessor :name, 
                :training_vector, 
                :weight_vector,
                :target, 
                :vector_size, 
                :transfer_parameter,
                :iterations,
                :values,
                :final,
                :output

  def initialize(data)
    @vector_size = data[:vector_size]
    @name = data[:name]
    @transfer_parameter = transfer_parameter
    @values = []    
    @final = []

    # Assign random weights
    #random_weights
  end

  def weight_vector
    @weight_vector
  end

  def random_weights
    weights = []
    for i in 1..@vector_size do
      weights << rand
    end

    @weight_vector = Vector.elements(weights)
  end

  #
  # METHODS
  #
  def train(data)
    # Turn data into Vector
    data_array = data.first(data.size - 1)
    
    @target = data.last

    # Add threshhold element
    data_array << -1.0
    @training_vector = Vector.elements(data_array)
    
    # Get @weight_vector size
    if @weight_vector.nil?
      @vector_size = @training_vector.size
      random_weights
    end

    # Calculate output using current weights
    rawvalue = @training_vector.inner_product(@weight_vector)
    value = 0 if rawvalue < 0
    value = 1 if rawvalue >= 0

    # Adjust the weights if necessary
    puts "{@training_vector}, {@weight_vector}, {@target}, {value}, {rawvalue}"
    puts "#{@training_vector}, #{@weight_vector}, #{@target}, #{value}, #{rawvalue}"
    while (@target - value).abs() != 0
      puts "#{@training_vector}, #{@weight_vector}, #{@target}, #{value}, #{rawvalue}"
      @weight_vector =  adjust_weight(@training_vector, @weight_vector, @target, value)
      rawvalue = inner_product(@training_vector, @weight_vector)

      value = 0 if rawvalue < 0
      value = 1 if rawvalue >= 0

      sleep 1
      @values << rawvalue
    end
    @final << value
    @output = value
  end

  def inner_product(first, second)
    value = 0.0
    first.each_with_index do |element, index|
      value = value + (element * second[index])
    end
    return value
  end

  def adjust_weight(training, weight, target, value)
    if value > target
      training.each_with_index do |element, index|
        if element >= 0 && index == (training.size - 1)
          weight[index] = weight[index] + 0.1
        elsif element >= 0
          weight[index] = weight[index] - 0.1
        end
      end
    else
      training.each_with_index do |element, index|
        if element >= 0 && index == (training.size - 1)
          weight[index] = weight[index] - 0.1
        elsif element >= 0
          weight[index] = weight[index] + 0.1
        end
      end
    end 
    return weight
  end

  def test(data)
    # Turn data into Vector
    data_array = data.first(data.size - 1)
    
    @target = data.last
    
    # Add threshhold element
    data_array << -1.0
    @training_vector = Vector.elements(data_array)
    
    # Calculate output using current weights
    rawvalue = @training_vector.inner_product(@weight_vector)
    value = 0 if rawvalue < 0
    value = 1 if rawvalue >= 0

    puts "#{@training_vector}, #{@weight_vector}, #{@target}, #{value}"
    @final << value

  end

  def transfer
    value = @input_vector.inner_product(@weight_vector)
  rescue => ex
    puts ex.message
    binding.pry
    return 0
  end

  def sigmoid
      value = @input_vector.inner_product(@weight_vector)
      activation = 1 / (1 + Math.exp(-value))
  rescue => ex
    puts ex.message
    binding.pry
    return 0
  end

  def save
    @input_vector = []
    @values = []
    @final = []
    if !@name.nil?
      $file = Time.now.strftime('%Y-%m-%d-%H-%M-%S-') << @name
    else
      $file = Time.now.strftime('%Y-%m-%d-%H-%M-%S-') << self.object_id.to_s
    end
    File.open("store/#{$file}", 'w') { |f| f.write(YAML.dump(self)) }
  end

end
