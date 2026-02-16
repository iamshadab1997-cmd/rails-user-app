Rails.application.routes.draw do
  # ---------------- ROOT ----------------
  root "users#index"

  # ---------------- USERS ----------------
  resources :users do
    resource :profile, only: [ :show, :new, :create, :edit, :update, :destroy ]

    member do
      get :remove_document
      patch :activate
    end

    collection do
      get :search
      get :active
    end

    # -------- PRODUCTS (USER-WISE) --------
    resources :products do
      collection do
        get :search
        get :featured
      end

      member do
        patch :toggle_stock
      end
    end
  end

  # ---------------- CART ----------------
  # One cart per user
  resource :cart do
    post "add/:product_id", to: "carts#add_item", as: :add_item
  end

  # ---------------- ADDRESSES ----------------
  resources :addresses do
    collection do
      get :recent
    end
  end

  # ---------------- ORDERS ----------------
  resources :orders do
    member do
      patch :cancel
      patch :complete
    end

    collection do
      get :pending
    end
  end

  # ---------------- CATEGORIES ----------------
  resources :categories do
    member do
      get :products
    end
  end

  # ---------------- OTHER RESOURCES ----------------
  resources :inventories

  resources :wishlists do
    member do
      patch :add_item
      patch :remove_item
    end
  end

  resources :reviews
  resources :comments

  resources :blog_posts do
    collection do
      get :recent
    end
  end

  resources :events do
    member do
      patch :publish
      patch :cancel
    end
  end

  resources :tickets
  resources :notifications
  resources :messages
  resources :subscriptions
  resources :support_tickets
  resources :audit_logs
  resources :payments
end
