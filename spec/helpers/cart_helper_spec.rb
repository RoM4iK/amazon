require 'rails_helper'

describe CartHelper, :not_verify_doubles do
  before do
    @helper = Object.new.extend CartHelper
    @book = FactoryGirl.build(:book)
    allow(@helper).to receive(:render)
  end
  describe '#add_to_cart_button' do
    it 'must create instance variable with book' do
      expect{@helper.add_to_cart_button(@book)}.to change{@helper.instance_variable_get(:@book)}.from(nil).to(@book)
    end
    it 'must render partial with button' do
      expect(@helper).to receive(:render).with(partial: 'cart/add_to_cart_button')
      @helper.add_to_cart_button(@book)
    end
  end
end
