require 'rails_helper'

describe OrderHelper, :not_verify_doubles, type: :helper do
  before do
    @helper = Object.new.extend OrderHelper
    @book = FactoryGirl.build(:book)
    allow(@helper).to receive(:render)
  end
  describe '#add_to_cart_button' do
    it 'must create instance variable with book' do
      expect{@helper.add_to_cart_button(@book)}.to change{@helper.instance_variable_get(:@book)}.from(nil).to(@book)
    end
    it 'must render partial with button' do
      expect(@helper).to receive(:render).with(partial: 'orders/add_to_cart_button')
      @helper.add_to_cart_button(@book)
    end
  end
end
