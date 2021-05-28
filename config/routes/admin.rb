authenticate :user do
  scope '/', module: 'admin', as: 'admin' do
    get 'feed', to: 'pages#feed', as: 'feed'

    # account
    get 'account/:id', to: 'account#show', as: 'user'
    post 'account/:id/send_follow_request', to: 'account#send_request', as: 'send_follow_request'
    post 'account/:id/accept_follow_request', to: 'account#accept_request', as: 'accept_follow_request'
    delete 'account/:id/delete_follow_request', to: 'account#delete_request', as: 'delete_follow_request'
    delete 'account/:id/delete_following', to: 'account#delete_following', as: 'delete_following'
    delete 'account/:id/delete_pending_request', to: 'account#delete_pending_request', as: 'delete_pending_request'

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
  end
end