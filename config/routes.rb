Rails.application.routes.draw do
  root 'welcome#index'

  get 'test' => 'welcome#test'


  get 'devices' => 'devices#index'
end
