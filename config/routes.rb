Rails.application.routes.draw do
  # if Rails.env.development? || Rails.env.staging?
  #   get 'stubs/:template', to: 'stubs#show', as: 'stubs_template'
  #   get 'stubs/:folder/:template', to: 'stubs#show', as: 'nested_stubs_template'
  #   get 'stubs/:layout/:folder/:template', to: 'stubs#show', as: 'layout_nested_stubs_template'
  # end
  resources :goals
  root to: 'static_pages#about'
end
