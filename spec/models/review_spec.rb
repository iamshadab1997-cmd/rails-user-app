require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { User.create!(name: "Test User", email: "test#{rand}@mail.com", password: "123456") }

  let(:product) do
    Product.create!(
      name: "Test Product",
      price: 100,
      user: user   # 👈 IMPORTANT FIX
    )
  end

  subject {
    described_class.new(
      user: user,
      product: product,
      rating: 5,
      title: "Great",
      reviewer_name: "Tester",
      comment: "Amazing product",
      approved: true
    )
  }

  it { should belong_to(:user) }
  it { should belong_to(:product) }

  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:reviewer_name) }
  it { should validate_inclusion_of(:rating).in_range(1..5) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
