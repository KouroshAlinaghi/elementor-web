ENV['APP_ENV'] = 'test'

require_relative '../server.rb'
require 'test/unit'
require 'rack/test'

class ElementorTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_empty_without_paramters
    get '/'
    assert !last_response.body.include?('table')
    assert not_error
  end

  def test_only_atomic_number_z_charge
    get '/', atomic_number: "2", charge: "0"
    assert last_response.body.include?('table')
    assert last_response.body.include?('Electron Configuration')
    assert last_response.body.include?('Helium')
    assert not_error
  end

  def test_atomic_number_is_first_z_charge
    get '/', atomic_number: "2", symbol: "H", charge: "0"
    assert last_response.body.include?('table')
    assert last_response.body.include?('Electron Configuration')
    assert last_response.body.include?('Helium')
    assert not_error
  end

  def test_symbol_z_charge
    get '/', symbol: "Ne", charge: "0"
    assert last_response.body.include?('table')
    assert last_response.body.include?('Neon')
    assert last_response.body.include?('Electron Configuration')
    assert not_error
  end

  def test_symbol_with_charge
    get '/', symbol: "Ar", charge: "-1"
    assert last_response.body.include?('table')
    assert last_response.body.include?('Argon')
    assert last_response.body.include?('18')
    assert not_error
  end

  def test_atomic_number_with_charge
    get '/', atomic_number: "22", charge: "1"
    assert last_response.body.include?('table')
    assert last_response.body.include?('23')
    assert last_response.body.include?('Vanadium')
    assert last_response.body.include?('Electron Configuration')
    assert not_error
  end

  def test_out_of_range_atomic_number
    get '/', atomic_number: "0", charge: "0"
    assert !last_response.body.include?('table')
    assert !not_error
    get '/', atomic_number: "119", charge: "0"
    assert !last_response.body.include?('table')
    assert !not_error
  end

  def test_wrong_symbol
    get '/', symbol: "bruh", charge: "0"
    assert !last_response.body.include?('table')
  end

  private def not_error
    !last_response.body.include?('error')
  end
end
