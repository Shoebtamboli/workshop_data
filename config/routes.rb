
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :participants do
    resources :feedback_links, only: [:show, :update], param: :token
    member do
      post 'send_feedback_link'
    end
  end
  root 'participants#index'
end

