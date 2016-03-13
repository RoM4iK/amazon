require 'rails_helper'

RSpec.describe SiteController, type: :controller do
  before do
    @instance = SiteController.new
  end
  describe '#index' do
    it 'must retrieve first 12 books' do
      expect(Book).to receive_message_chain(:all, :limit).with(12)
      @instance.index
    end
    it 'must store books to instance variable' do
      books = double("books")
      allow(Book).to receive_message_chain(:all, :limit) { books }
      expect{@instance.index}.to change {@instance.instance_variable_get(:@books)}.to(books)
    end
  end
end
