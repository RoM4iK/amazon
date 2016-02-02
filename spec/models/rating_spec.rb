require 'rails_helper' 

RSpec.describe Rating, type: :model do
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:customer) }
    
  it { is_expected.to validate_presence_of(:rate) }
  it { is_expected.to validate_numericality_of(:rate).only_integer.is_less_than(6) }
end
