require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(customer) }
  let(:customer) { nil }

  context 'customer is admin' do
    let(:customer) { FactoryGirl.create :customer, admin: true }

    it { expect(ability).to be_able_to(:access, :rails_admin) }
    it { expect(ability).to be_able_to(:manage, :all) }
  end

end
