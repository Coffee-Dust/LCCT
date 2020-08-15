Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'LCCT/overview', to: 'case_data#overview'
  get 'LCCT/week', to: 'case_data#week_overview'
end
