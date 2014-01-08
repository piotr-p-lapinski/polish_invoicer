require 'test_helper'

module PolishInvoicer
  class InvoiceTest < MiniTest::Unit::TestCase
    def test_init
      i = Invoice.new
      assert i.is_a?(Invoice)
    end

    def test_set_available_param
      i = Invoice.new({number: '1/2014'})
      assert_equal '1/2014', i.number
    end

    def test_set_unavailable_param
      assert_raises(RuntimeError) { i = Invoice.new({test: 'abc'}) }
    end

    def test_validation_delegation
      i = Invoice.new
      assert_equal false, i.valid?
      assert i.errors[:number]
      i.number = '1/2014'
      i.valid?
      assert_nil i.errors[:number]
    end
  end
end
