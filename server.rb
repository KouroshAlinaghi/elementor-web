require 'sinatra'
require 'little_elementor'

set :bind, ENV["ELEMENTOR_HOST"]
set :port, ENV["ELEMENTOR_PORT"]

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

  begin
    e = get_el()
    erb :index, locals: {element: e}
  rescue
    "We Have An Error!"
  end
end
