require 'rails_helper' 

RSpec.describe Address, type: :model do
  it { is_expected.to have_one(:country) }
    
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:zipcode) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:country) } 
end
