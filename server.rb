require 'sinatra'
require 'little_elementor'

set :bind, ENV["EL_HOST"]

get "/" do
  def get_el()
    if params.has_key?(:atomic_number) && !params[:atomic_number].empty?
      e = LittleElementor::Element.new(atomic_number: params[:atomic_number].to_i, charge: params[:charge].to_i)
    elsif params.has_key?(:symbol) && !params[:symbol].empty?
      e = LittleElementor::Element.new(symbol: params[:symbol], charge: params[:charge].to_i)
    else
      e = nil
    end
  end

  def electron_configuration_to_s(e_c)
    str = ""
    e_c.each {|o| str += "#{o.n}#{LittleElementor::Helpers::L[o.l]}<sup>#{o.electrons_count}</sup>, " }
    str[0..str.length-3]
  end

  begin
    e = get_el()
    erb :index, locals: {element: e, error: false}
  rescue 
    erb :index, locals: {error: true, element: nil}
  end
end
