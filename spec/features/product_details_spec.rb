require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js:true  do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    visit root_path
    page.find('.products').first(:link, "Details").click
    expect(page).to have_css '.product-detail', count: 1
    save_screenshot
  end
end