# encoding: utf-8
require 'test_helper'

module PolishInvoicer
  class PresenterTest < MiniTest::Unit::TestCase
    require 'ostruct'

    def setup
      @invoice = OpenStruct.new
    end

    def test_format_dates
      @invoice.trade_date = Date.parse('2014-01-01')
      @invoice.create_date = Date.parse('2014-01-15')
      @invoice.payment_date = Date.parse('2014-01-30')
      data = Presenter.new(@invoice).data
      assert_equal '01.01.2014', data[:trade_date]
      assert_equal '15.01.2014', data[:create_date]
      assert_equal '30.01.2014', data[:payment_date]
    end

    def test_format_prices
      @invoice.net_value = 123.4567
      @invoice.vat_value = 23.9876
      @invoice.gross_value = 456.3378
      data = Presenter.new(@invoice).data
      assert_equal '123,46', data[:net_value]
      assert_equal '23,99', data[:vat_value]
      assert_equal '456,34', data[:gross_value]
    end

    def test_format_comments
      @invoice.comments = nil
      data = Presenter.new(@invoice).data
      assert_equal [], data[:comments]
      @invoice.comments = 'Test'
      data = Presenter.new(@invoice).data
      assert_equal ['Test'], data[:comments]
      @invoice.comments = ['A', 'B']
      data = Presenter.new(@invoice).data
      assert_equal ['A', 'B'], data[:comments]
    end
  end
end
