require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:quantity) }
  
  it { is_expected.to have_many(:ratings) }
  it { is_expected.to belong_to(:author) }
  it { is_expected.to belong_to(:category) }
end
