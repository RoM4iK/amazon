require 'rails_helper'

describe ApplicationController, type: :controller do
  before do
    @instance = ApplicationController.new
  end
  describe '#current_ability' do
    it 'must return current ability if present' do
      ability = double("ability")
      @instance.instance_variable_set(:@current_ability, ability)
      expect(@instance.current_ability).to equal(ability)
    end
    it 'must create new ability if no present', :not_verify_doubles do
      customer = FactoryGirl.build(:customer)
      allow(@instance).to receive(:current_customer) { customer }
      expect(Ability).to receive(:new).with(customer)
      @instance.current_ability
    end
  end
  describe '#global_data' do
    it 'must fill categories variable with all categories' do
      categories = double("categories")
      allow(Category).to receive(:all) { categories }
      expect{@instance.send(:global_data)}.to change{@instance.instance_variable_get(:@categories)}.to(categories)
    end
  end
end
