require 'rails_helper'

RSpec.describe Author, type: :model do
  it { is_expected.to have_many(:books) }
    
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  
  describe "#full_name" do
    before do
      @author = FactoryGirl.build(:author)
    end
    it 'must return first name + last name' do
      expect(@author.full_name).to eq("#{@author.first_name} #{@author.last_name}")
    end
  end
end
