require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    @instance = BooksController.new
  end

  describe '#index' do
    it 'must retrieve all books, and save it to instance variable' do
      books = double("books")
      allow(Book).to receive(:all) { books }
      expect{@instance.index}.to change{ @instance.instance_variable_get(:@books) }.to(books)
    end
  end

  describe '#show' do
    it 'must change page title to book title' do
      book = FactoryGirl.build(:book)
      @instance.instance_variable_set(:@book, book)
      expect{@instance.show}.to change{@instance.instance_variable_get(:@page_title)}.to(book.title)
    end
  end

  describe '#category' do
    before do
      @category = FactoryGirl.build(:category)
      @books = double("books")
      allow(Category).to receive(:find) { @category }
      allow(@instance).to receive_message_chain(:params, :[])
      allow(Book).to receive_message_chain(:where, :limit) { @books }
    end
    it 'must retrieve the category' do
      expect(Category).to receive(:find)
      @instance.category
    end
    it 'must retrieve book of selected category' do
      expect(Book).to receive(:where).with(category: @category)
      @instance.category
    end
    it 'must assign books to instance variable' do
      expect{@instance.category}.to change{@instance.instance_variable_get(:@books)}.to(@books)
    end
  end
end
