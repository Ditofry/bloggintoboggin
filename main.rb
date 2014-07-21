require 'sinatra'
require 'haml'
require 'coffee-script'
require 'data_mapper'

set :views, File.dirname(__FILE__) + "/views"
use Rack::Static, :urls => ['/css', '/js'], :root => 'public'

get '/' do
  "hello, world."
  haml :index
end

get '/fibonacci' do
  f = FibText.new
  @content = f.fibonize()
  haml :fibonacci
end

get '/about' do
  haml :about
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
    row = 0
    low_bound = 1
    content = Array.new
    content[row] = Array.new
    # Fib sequence
    f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }
    # Build Pyramid
    while a.any?
      upp_bound = f[i]
      i += 1
      fib_size = upp_bound - low_bound
      fib_size.times do
        if a.length > 0
          content[row] << a.shift
        end
      end
      low_bound = upp_bound
      if a.length > 0
        row += 1
        content[row] = Array.new
      end
    end
    return content
  end

end
