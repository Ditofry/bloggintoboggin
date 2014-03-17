require 'sinatra'

get '/' do
  "Well hello, world."
end

get '/fibonacci' do 
  f = FibText.new
  f.fibonize_web
end

class FibText
  
  def initialize(text = nil)
    dummy = 'Here is a little bit of dummy text in fibonacci form'
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
          content += '<div class="word">' a.shift + '</div>' 
        end
      end
      low_bound = upp_bound
      if a.length > 0 
        content += "<br>"
      end
    end
    return content
  end

end

# F(n) = F(n-1) + F(n-2)
# Then each member of the fibonacci sequence is defined by the sum of 
# the two preceding numbers
#
# We'll want to split the input text into an array, with space as a word delimeter:
# string.split(' ')
# 
# Once we have our array, we'll need to chunk through it and place words in the 
# right place
# 
# We eventually want to center it, to make a pyramid
# 
# We may want to find the size of the final row immediately to determine width
# of base and the positioning of each element
