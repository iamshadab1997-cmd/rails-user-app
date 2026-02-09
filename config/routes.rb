Rails.application.routes.draw do
  # Root
  root "users#index"

  # ---------------- USERS (with singular nested profile) ----------------
  resources :users do
    # Singular nested profile (one profile per user)
    resource :profile, only: [:show, :new, :create, :edit, :update, :destroy]

    # MEMBER routes
  member do
  get :remove_document  # allows GET
end

    # COLLECTION routes
    collection do
      get :search               # Search users
    end
  end

  # ---------------- BASIC CRUD ----------------
  resources :carts
  resources :addresses

  # ---------------- ORDERS ----------------
  resources :orders do
    member do
      patch :cancel             # Cancel specific order
    end
  end

  # ---------------- PRODUCTS ----------------
  resources :products do
    collection do
      get :search               # Search products
    end
  end

  # ---------------- OTHER RESOURCES ----------------
  resources :categories
  resources :inventories
  resources :wishlists
  resources :reviews
  resources :blog_posts
  resources :comments
  resources :events
  resources :tickets
  resources :notifications
  resources :messages
  resources :subscriptions
  resources :support_tickets
  resources :audit_logs
  resources :payments
end
