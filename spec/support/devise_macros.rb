module DeviseMacros
  def login
    before(:each) do
      customer = FactoryGirl.create(:customer)
      sign_in customer
    end
  end
end
