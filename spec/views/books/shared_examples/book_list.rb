RSpec.shared_examples "a book list" do
  context "with books" do
    before do
      @books = @books_list
      render
    end
    it "renders a list of books" do
      expect(rendered).to have_selector('.books-list')
    end
    it 'renders book widget' do
      expect(rendered).to have_selector('.book-widget')
    end
  end
  context "without books" do
    before do
      render
    end
    it "renders a list of books" do
      expect(rendered).to have_selector('.books-list')
    end
    it "doesn't render any book widget" do
      expect(rendered).not_to have_selector('.book-widget')
    end
  end
end
