require 'sinatra'
set :static, true

get '/' do
  "Well hello, world."
end

get '/fibonacci' do 
  f = FibText.new
  erb f.fibonize_web
end

class FibText
  
  def initialize(text = nil)
    dummy = 'Banksy Tumblr gastropub stumptown kitsch gluten-free. 
    Dreamcatcher slow-carb roof party, gastropub disrupt biodiesel 
    YOLO Banksy tote bag. Pop-up vinyl bitters, post-ironic sustainable 
    master cleanse Schlitz Thundercats leggings sriracha. Four loko 
    8-bit street art, mixtape tousled paleo aesthetic banh mi. Kale 
    chips swag photo booth, bespoke literally flannel distillery 
    scenester chillwave meh Bushwick shabby chic flexitarian Tonx 
    slow-carb. Selfies readymade roof party narwhal messenger bag. Trust 
    fund twee fap synth keffiyeh next level sustainable Austin, selvage 
    disrupt Wes Anderson ethnic Bushwick pug.'
    @text = text ? text : dummy
  end

  def fibonize
    a = @text.split(' ')
    i = 3
    low_bound = 1
    content = ''
    # Fib sequence
    f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }
    # Build Pyramid
    while a.any?
      upp_bound = f[i]
      i += 1
      fib_size = upp_bound - low_bound
      fib_size.times do
        if a.length > 0 
          content += a.shift + ' ' 
        end
      end
      low_bound = upp_bound
      if a.length > 0 
        content += "\n"
      end
    end
    return content
  end

  def fibonize_web
    a = @text.split(' ')
    i = 3
    low_bound = 1
    content = '<div class="row">'
    # Fib sequence
    f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }
    # Build Pyramid
    while a.any?
      upp_bound = f[i]
      i += 1
      fib_size = upp_bound - low_bound
      fib_size.times do
        if a.length > 0 
          content += '<div class="word">' + a.shift + '</div>' 
        end
      end
      low_bound = upp_bound
      if a.length > 0 
        content += "</div><div class='row'>"
      end
    end
    return content
  end

end
 
# We eventually want to center it, to make a pyramid
# 
# We may want to find the size of the final row immediately to determine width
# of base and the positioning of each element
