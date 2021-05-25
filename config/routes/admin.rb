authenticate :user do
  scope '/', module: 'admin', as: 'admin' do
    get 'feed', to: 'pages#feed', as: 'feed'
  end
end