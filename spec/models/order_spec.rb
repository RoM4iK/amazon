require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:credit_card) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:order_items) }
    
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:credit_card) }
  it { is_expected.to validate_presence_of(:customer) }
  
  describe '#add_book' do
    it 'creates new order_item'
    it 'assign order_items to current order'
    it 'change the total price of order'
  end
  describe '#remove_book' do
    it 'deletes order_item'
    it 'changes the total price of order'
  end
  
end
