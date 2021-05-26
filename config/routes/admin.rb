authenticate :user do
  scope '/', module: 'admin', as: 'admin' do
    get 'feed', to: 'pages#feed', as: 'feed'
    get 'profile', to: 'pages#profile', as: 'profile'

    get 'account/:id', to: 'account#show', as: 'user'

    resources :posts
  end
end