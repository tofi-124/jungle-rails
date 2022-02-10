require 'rails_helper'
RSpec.feature "User navigates to index page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario " All products are shown" do
    visit root_path
    save_screenshot
    expect(page).to have_css 'article.product'
  end
end