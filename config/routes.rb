Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end
  
  get '/dashboard' => 'welcome#index'

  resources :redcorporativa_interfaces

  resources :cacheudni_interfaces

  resources :preagg_interfaces

  resources :cacheakamai_interfaces

  resources :cachenetflix_interfaces

  resources :session_accedians

  resource :ppmreports, only: [:show] do
    resources :ppmroutes, only: [:index, :show, :create]
    resources :ppminterfaceinternets
    resources :ppminterfacecores, only: [:index, :show, :create]
    resources :ppminterfacepreaggs, only: [:index, :show, :create]
    resources :ppmpacketcores, only: [:index, :show, :create]
    resources :ppmreportcaches, only: [:show]
    resources :ppminterfaceclientinternets, only: [:index, :show, :create]
    resources :ppmredcorporativainterfaces, only: [:index, :show, :create]
  end

  resource :ppmreportcaches, only: [:show] do
    resources :ppmcachegoogles, only: [:index, :show, :create]
    resources :ppmcachefacebooks, only: [:index, :show, :create]
    resources :ppmcachenetflixs, only: [:index, :show, :create]
    resources :ppmcacheakamais, only: [:index, :show, :create, :my_results]
    resources :ppmcacheudns, only: [:index, :show, :create]
  end

  resource :samreports, only: [:show] do 
    resources :samcpus, only: [:index, :show, :create]
    resources :samreportroutes, only: [:show]
    resources :sammemos, only: [:index, :show, :create]
    resources :samenvironments, only: [:index, :show, :create]
    resources :samqosdiscards, only: [:show]
    resources :samqosreports, only: [:show]
  end

  resource :samqosdiscards, only: [:show] do
    resources :samutilizationinterfaces, only: [:index, :show, :create]
    resources :samutilizationaccesointerfaces, only: [:index, :show, :create]
    resources :samaztecainterfaces, only: [:index, :show, :create]
    resources :samgilatinterfaces, only: [:index, :show, :create]
    resources :saminternexainterfaces, only: [:index, :show, :create]
    resources :saminterfacediscards, only: [:index, :show, :create]
    resources :samstatusports, only: [:index, :show, :create]
    resources :samutilizationmwinterfaces, only: [:index, :show, :create]
  end

  resource :samreportroutes, only: [:show] do
    resources :samrouteospfs, only: [:index, :show, :create]
    resources :samroutevprns, only: [:index, :show, :create]
    resources :samrouteldps, only: [:index, :show, :create]
    resources :samroutebgps, only: [:index, :show, :create]
  end

  resource :samreportalarmas, only: [:show] do
    resources :samospfalarmas, only: [:index, :show, :create]
  end

  resource :samqosreports, only: [:show] do
    resources :samqos7705egressdiscards, only: [:index, :show, :create]
    resources :samqos7705ingressdiscards, only: [:index, :show, :create]
    resources :samqos7750egressdiscards, only: [:index, :show, :create]
    resources :samqos7750ingressdiscards, only: [:index, :show, :create]
    resources :samqos7705egressnetdiscards, only: [:index, :show, :create]
    resources :samqos7705ingressnetdiscards, only: [:index, :show, :create]
    resources :samqos7750egressnetdiscards, only: [:index, :show, :create]
    resources :samqos7750ingressnetdiscards, only: [:index, :show, :create]
  end

  resource :tailfpages, only: [:show] do 
  end

  resource :arborreports, only: [:show] do 
  end
 
  resource :summaryreports, only: [:show] do
    resource :utilizationreports, only: [:show]
    resource :utilizationaccessreports, only: [:show]
    resource :utilizationcachereports, only: [:show]
  end

  resources :internet_interfaces
  resources :core_interfaces
  resources :ipranedge_interfaces
  resources :access_internets
  resources :cachefacebook_interfaces
  resources :cachegoogle_interfaces
  resources :ipranaccess_interfaces

  namespace :charts do
    get "traffic_internetinterfaces"
  end

end