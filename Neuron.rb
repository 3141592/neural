# 
# A single artificial neuron.
#
require 'yaml'
require 'pry'

class Neuron
  attr_accessor :name, 
                :data, 
                :dirname, 
                :training_data, 
                :input_array,
                :target_array, 
                :vector_size, 
                :transfer_parameter

  def initialize(data)
    @vector_size = data[:vector_size]
    @name = data[:name]
    @data = data[:data]
    @training_data = data[:training_data]
    @input_array = []
    @target_array = []
    
    @dirname = File.dirname(__FILE__)
    
    # Loop through training data
    file = File.open("#{dirname}/data/#{@training_data}")
    
    file.each do |row|
      row.gsub!("\n","")
      temp_array = row.split(",")
      temp_array.map!(&:to_f)
      @input_array << (temp_array.first temp_array.size - 1)
      @target_array << temp_array.last
    end

    random_weights
    @transfer_parameter = transfer_parameter
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
  def train
    # Loop through training data
    file = File.open("#{dirname}/data/#{@training_data}")
    
    file.each do |row|
      row.gsub!("\n","")
      @input
      binding.pry
    end

    # Calculate output using current weights

    # Adjust the weights if necessary

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
