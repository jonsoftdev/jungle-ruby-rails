RSpec.describe Product, type: :model do
  describe 'Validations' do
  
    before do
      @category = Category.create(name: "Flowers")
      @product = @category.product.create({name: "Rose", price: 100, quantity: 10, category: @category})
  end

  it "is valid with valid attributes" do
    expect(@product).to be_valid
  end
  
end