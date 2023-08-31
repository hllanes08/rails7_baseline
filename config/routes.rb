Rails.application.routes.draw do
  devise_scope :user do
    scope "users", controller: 'users/saml_session' do
      get :new, path: "saml/sign_in", as: :new_user_sso_session
      post :create, path: "saml/auth", as: :user_sso_session
      get :metadata, path: "saml/metadata", as: :metadata_user_sso_session
    end
  end
  devise_for :users,  skip: [:saml_authenticatable], controllers: {
    sessions: 'devise/sessions', as: :new_user_session
  }
  root to: 'home#index'


end
