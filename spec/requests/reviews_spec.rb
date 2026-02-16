require 'rails_helper'

RSpec.describe "Reviews API", type: :request do
  let!(:user) do
    User.create!(
      name: "Test",
      email: "test#{rand}@mail.com",
      password: "123456"
    )
  end

  let!(:product) do
    Product.create!(
      name: "Test Product",
      price: 100,
      user: user   # ✅ IMPORTANT FIX
    )
  end

  let!(:review) do
    Review.create!(
      user: user,
      product: product,
      rating: 4,
      title: "Nice",
      reviewer_name: "Tester",
      comment: "Good product",
      approved: true
    )
  end

  describe "GET /reviews" do
    it "returns list of reviews" do
      get "/reviews"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /reviews/:id" do
    it "returns a review" do
      get "/reviews/#{review.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /reviews" do
    it "creates a review" do
      post "/reviews", params: {
        review: {
          user_id: user.id,
          product_id: product.id,
          rating: 5,
          title: "Excellent",
          reviewer_name: "Tester",
          comment: "Awesome",
          approved: true
        }
      }

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /reviews/:id" do
    it "updates review" do
      patch "/reviews/#{review.id}", params: {
        review: { rating: 3 }
      }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /reviews/:id" do
    it "deletes review" do
      delete "/reviews/#{review.id}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET invalid id" do
    it "returns 404" do
      get "/reviews/999999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
