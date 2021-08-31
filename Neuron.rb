# 
# A single artificial neuron.
#
require 'pry'

class Neuron
  attr_accessor :vector_size, :transfer_parameter

  def initialize(data)
    @vector_size = data[:vector_size]
    @input_array = []

    random_weights
    @transfer_parameter = transfer_parameter
  end

  def add_input(vector)
    if vector.size == @vector_size
      @input_array << vector 
    else
      throw "InvalidVectorSizeException"
    end
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
  def add_input_vector(input_array)
    @input_array << Vector.elements(input_array)
  end

  def transfer
    activation = 0
    @input_array.each do |vector|
      value = vector.inner_product(@weight_vector)
      activation = activation + value
    end
    activation
  end

  def sigmoid
    
    return 
  end

end
