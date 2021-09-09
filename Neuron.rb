# 
# A single artificial neuron.
#
require 'yaml'
require 'pry'

class Neuron
  attr_accessor :name, 
                :training_vector, 
                :target, 
                :vector_size, 
                :transfer_parameter

  def initialize(data)
    @vector_size = data[:vector_size]
    @name = data[:name]
    @transfer_parameter = transfer_parameter
    
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
    input = data_array.first(data_array.size - 1)
    
    @target = data_array.last
    @training_vector = Vector.elements(input)

    # Get @weight_vector size
    if @weight_vector.nil?
      @vector_size = @training_vector.size
      random_weights
    end

    # Calculate output using current weights
    value = @training_vector.inner_product(@weight_vector)

    # Adjust the weights if necessary
    while @target != value
      adjust_weight(@training_vector, @target, value)
      value = @training_vector.inner_product(@weight_vector)
    end
  end

  def adjust_weight(training, target, value)
    if value > target
      training.each do |element|
        if element > 0
          binding.pry
          #@weight_vector = @target_vector * 
        end
      end
    else
      training.each do |element|
        if element > 0

        end
      end
    end 
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
    if !@name.nil?
      $file = Time.now.strftime('%Y-%m-%d-%H-%M-%S-') << @name
    else
      $file = Time.now.strftime('%Y-%m-%d-%H-%M-%S-') << self.object_id.to_s
    end
    File.open("store/#{$file}", 'w') { |f| f.write(YAML.dump(self)) }
  end

end
