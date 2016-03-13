require 'rails_helper'

describe BooksHelper, type: :helper do
  before do
    @helper = Object.new.extend BooksHelper
  end
  describe '#average_rating' do
    it "must retrieve average rate from book ratings" do
      @book = FactoryGirl.build(:book)
      expect(@book).to receive_message_chain(:ratings, :average).with(:rate)
      @helper.average_rating(@book)
    end
    it "must round average if it's float" do
      @book = FactoryGirl.build(:book)
      @rate = 1.1
      allow(@book).to receive_message_chain(:ratings, :average) { @rate }
      expect(@helper.average_rating(@book)).to be_a(Fixnum)
    end
  end
end
