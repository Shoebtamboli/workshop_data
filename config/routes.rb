Rails.application.routes.draw do
  resources :participants do
    resources :feedback_links, only: [:show, :update], param: :token
    member do
      post 'send_feedback_link'
    end
  end
  get 'feedback_summary', to: 'participants#feedback_summary'
  root 'participants#feedback_summary'
end