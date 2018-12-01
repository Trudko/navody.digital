Rails.application.routes.draw do
  root to: 'static#index'

  get :health, to: 'health#index'

  namespace :admin do
    root to: 'dashboard#show'

    resources :journeys
  end

  get '/static/:slug', to: 'static#show', as: 'static_page', defaults: {is_faq: false}
  get '/faq/:slug', to: 'static#show', as: 'faq_page', defaults: {is_faq: true}

  get '/zivotne-situacie', to: redirect('/')
  get '/zivotne-situacie/:slug', to: 'journeys#show', as: 'journey'
  get '/zivotne-situacie/:slug/:step_slug', to: 'journeys#show', as: 'journey_step'
end
