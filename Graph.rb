#
# Create a graph from data
#
require 'uri'
require 'net/http'

# 
# https://image-charts.com/chart
# ?cht=<chart_type>
# &chd=<chart_data>
# &chs=<chart_size>
# &...additional_parameters...
# 
# cht=lc  # Just y values
# cht=lxy # x and y values
# 
# Example
# https://image-charts.com/chart?chs=700x190&chd=t:60,40&cht=p3&chl=Hello%7CWorld&chan&chf=ps0-0,lg,45,ffeb3b,0.2,f44336,1|ps0-1,lg,45,8bc34a,0.2,009688,1
# 

def get_filename(name)
  $file = "images/" << Time.now.strftime('%Y-%m-%d-%H-%M-%S-') << "#{name}.jpg"
end

def create_graph_lxy(xvalues, yvalues)
  get_filename

  cht = "lxy"
  chd = "t:"

  # x values
  xvalues.each do |x|
    chd << "#{x.to_f},"
  end
  chd.gsub!(/\,+$/, '|')  

  # y values
  yvalues.each do |y|
    chd << "#{y.to_f},"
  end
  chd.gsub!(/\,+$/, '|')  

  # Chart size
  chs = "700x100"

  request_url = "https://image-charts.com/chart?cht=#{cht}&chs=#{chs}&chd=#{chd}"
  puts request_url  

  uri = URI(request_url)
  res = Net::HTTP.get_response(uri)
  File.write($file , res.body) if res.is_a?(Net::HTTPSuccess)

end

def create_graph_lx(name, yvalues)
  get_filename(name)

  cht = "lc"
  chd = "t:"

  # y values
  yvalues.each do |y|
    chd << "#{y.to_f},"
  end
  chd.gsub!(/\,+$/, '|')  

  # Chart size
  chs = "700x100"

  request_url = "https://image-charts.com/chart?cht=#{cht}&chs=#{chs}&chd=#{chd}"
  puts request_url  

  uri = URI(request_url)
  res = Net::HTTP.get_response(uri)
  File.write($file, res.body) if res.is_a?(Net::HTTPSuccess)

end
