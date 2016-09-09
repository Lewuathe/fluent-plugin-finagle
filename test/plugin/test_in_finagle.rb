require 'helper'

require 'fluent/test'
require 'fluent/plugin/in_finagle'

class FinagleInputTest < Test::Unit::TestCase

  CONFIG = %[
finagle_host 127.0.0.1
finagle_port 9990
metrics metricA,metricB
  ]
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf=CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::FinagleInput).configure(conf, true)
  end

  def test_configure
    d = create_driver
    assert_equal '127.0.0.1', d.instance.finagle_host
    assert_equal '9990', d.instance.finagle_port
    assert_equal "metricA,metricB", d.instance.metrics
  end
end
