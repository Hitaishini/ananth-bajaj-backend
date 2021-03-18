Rails.application.routes.draw do
  devise_for :users
  # API Definition
  #API for password reset common for both web and mob
  put '/update_passwords' => 'devise/passwords#update_password'
  #post '/update_passwords' => 'devise/passwords#update_password'
  resource :uploads
  #root 'uploads#upload_bikes'
  resource :uploads do
    collection { 
      post :import
      post :import_users
      post :import_service_history 
      post :import_prices 
      post :import_specifications
      post :import_key_features 
      post :import_colors
      post :import_service_schedules
      post :import_accessories
      post :import_faqs
      post :import_varients
      post :import_used_bikes
      post :import_user_bikes 
    }
  end
  #for price value csv download
  get '/download_price_value_date' => 'uploads#download_price_value_date'
  get '/upload_accessories' => 'uploads#upload_accessories'
  get '/upload_bikes' => 'uploads#upload_bikes'
  get '/upload_specifications' => 'uploads#upload_specifications'
  get '/upload_users' => 'uploads#upload_users'
  get '/upload_service_history' => 'uploads#upload_service_history'
  get '/upload_prices' => 'uploads#upload_prices'
  get '/upload_key_features' => 'uploads#upload_key_features'
  get '/upload_colors' => 'uploads#upload_colors'
  get '/upload_service_schedules' => 'uploads#upload_service_schedules'
  get '/download_users' => 'uploads#download_users'
  get '/download_bikes' => 'uploads#download_bikes'
  get '/upload_faqs' => 'uploads#upload_faqs'
  get '/download_faqs' => 'uploads#download_faqs'
  get '/upload_varients' => 'uploads#upload_varients'
  #upload my bikes with user
  get '/upload_user_bikes' => 'uploads#upload_user_bikes'
  get '/down_user_bikes' => 'uploads#down_user_bikes'
  
  get '/upload_used_bikes' => 'uploads#upload_used_bikes'
  get '/down_load_used_bikes' => 'uploads#down_load_used_bikes'
  get '/download_specifications' => 'uploads#download_specifications'
  get '/download_key_features' => 'uploads#download_key_features'
  get '/down_load_accessories' => 'uploads#down_load_accessories'
  get '/down_load_bike_colors' => 'uploads#down_load_bike_colors'
  get '/down_load_service_history' => 'uploads#down_load_service_history'
  get '/down_load_service_schedule' => 'uploads#down_load_service_schedule'
  get '/down_load_varients' => 'uploads#down_load_varients'


  
  namespace :web, defaults: { format: :json }, path: '/web/' do
    scope module: :v1 do
    # We are going to list our resources here
    #for used bikes
    resources :used_bikes
    resources :vehicle_faqs  
    post '/destroy_all_vehicle_faqs' => 'vehicle_faqs#destroy_all_vehicle_faqs'

    post '/delete_used_bikes' => 'used_bikes#delete_used_bikes'
    post '/delete_used_bike_image' => 'used_bikes#delete_used_bike_image'
    resources :used_bike_models
    resources :used_bike_enquiries

    resources :accessory_tags
    resources :tags
    resources :users, :only => [:create, :show, :update, :destroy, :index]
    post '/delete_users' => 'users#delete_users'
    post '/get_my_bikes' => 'users#get_my_bikes'
    post '/delete_service_bookings' => 'service_bookings#delete_service_bookings'
    post '/delete_enquiries' => 'enquiries#delete_enquiries'
    post '/delete_feedbacks' => 'feedbacks#delete_feedbacks'

    resources :sessions, :only => [:create, :destroy]
    resource :api_token
    resources :profiles
    #specification names
    post '/delete_specification_names' => 'specification_names#delete_specification_names'
    resources :specification_names
    post '/specifications_by_type' => "specification_names#specifications_by_type"
    #audits
    get '/audit_lgs' => 'audit#audit_logs'
    post '/delete_profiles' => 'profiles#delete_profiles'
    post '/profile_image_update' => 'profiles#profile_image_update'
    resources :hog_registrations
    post '/delete_hog_registrations' => 'hog_registrations#delete_hog_registrations'
    post '/hog_registration_image_update' => 'hog_registrations#hog_registration_image_update'
    resources :bike_types
    post '/delete_bike_types' => 'bike_types#delete_bike_types'
    resources :bikes
    get '/get_all_bikes' => 'bikes#get_all_bikes'
    post '/delete_all_bikes' => 'bikes#delete_bikes'
    #non bajaj vehicles api
    get '/get_non_bajaj_vehicles' => 'bikes#get_non_bajaj_vehicles'
    resources :specifications
    post '/delete_specifications' => 'specifications#delete_specifications'
    resources :specification_types
    post '/delete_specification_types' => 'specification_types#delete_specification_types'
    resources :test_rides
    post '/delete_test_rides' => 'test_rides#delete_test_rides'
    resources :varients
    post '/delete_varients' => 'varients#delete_varients'
      #api for the admin dashboard all bookings
      post '/get_all_bookings' => 'test_rides#all_bookings'
      post '/bookings_with_day' => 'test_rides#bookings_with_day'
      post '/bookings_with_count' => 'test_rides#bookings_with_count'
      post '/get_bookings_by_period' => 'dashboards#bookings_by_period'
      resources :accessory_enquiries
      #delete wishlists
      post '/wishlist_delete' => 'accessory_enquiries#wishlist_delete'
      post '/delete_wishlists' => 'accessory_enquiries#delete_wishlists'
      resources :service_bookings
      post '/delete_service_bookings' => 'service_bookings#delete_service_bookings'
      resources :my_bikes
      post '/delete_my_bikes' => 'my_bikes#delete_my_bikes'
      post '/my_bike_image_update' => 'my_bikes#my_bike_image_update'
      resources :feedbacks   #, only: [:index, :show, :create]
      resources :insurance_renewals, except: [:delete]
      post '/delete_insurance_renewals' => 'insurance_renewals#delete_insurance_renewals'
      resources :enquiries, except: [:delete]
      resources :booking_time_controls
      post '/delete_booking_time_controls' => 'booking_time_controls#delete_booking_time_controls'
      resources :key_feature_types
      post '/delete_key_feature_types' => 'key_feature_types#delete_key_feature_types'
      resources :key_features
      post '/delete_key_features' => 'key_features#delete_key_features'
      resources :price_fields
      post '/delete_price_fields' => 'price_fields#delete_price_fields'
      resources :pricings
      post '/delete_pricings' => 'pricings#delete_pricings'
      resources :bike_colors
      post '/delete_bike_colors' => 'bike_colors#delete_bike_colors'
      resources :accessories
      post '/delete_accessories' => 'accessories#delete_accessories'
      post '/update_accessory_image' => 'accessories#update_accessory_image'
      get '/get_accessories_enquiries' => 'accessories#get_accessories_enquiries'
      resources :accessory_categories
      post '/delete_accessory_categories' => 'accessory_categories#delete_accessory_categories'
      post '/update_accessory_categery_image' => 'accessories#update_accessory_categery_image'
      resources :events
      post '/delete_events' => 'events#delete_events'
      post '/user_with_event_information' => 'events#user_event_inforamtion'
      resources :rides
      post '/delete_rides' => 'rides#delete_rides'
      post '/user_with_ride_information' => 'rides#user_inforamtion'
      resources :my_docs
      post '/delete_my_docs' => 'my_docs#delete_my_docs'
      post '/my_docs_image_update' => 'my_docs#my_docs_image_update'
      resources :email_notification_templates
      post '/delete_email_notification_templates' => 'email_notification_templates#delete_email_notification_templates'
      resources :notification_templates
      post '/delete_notification_templates' => 'notification_templates#delete_notification_templates'
      #get all categories
      # get '/get_notification_category' => 'notification_templates#notification_category'
      # get '/get_email_notification_category' => 'email_notification_templates#email_template_category'
      resources :dealer_types
      post '/delete_dealer_types' => 'dealer_types#delete_dealer_types'
      resources :dealers
      post '/delete_dealers' => 'dealers#delete_dealers'
      post '/dealers_image_update' => 'dealers#dealers_image_update'
      resources :set_booking_numbers
      resources :finance_documents
      post '/delete_finance_documents' => 'finance_documents#delete_finance_documents'
      resources :tenures
      post '/delete_tenures' => 'tenures#delete_tenures'
      resources :banners
      post '/delete_banners' => 'banners#delete_banners'
      post '/update_image' => 'banners#update_image'
      resources :service_schedules
      post '/delete_service_schedules' => 'service_schedules#delete_service_schedules'
      resources :set_rules
      post '/delete_set_rules' => 'set_rules#delete_set_rules'
      resources :notification_categories
      post '/delete_notification_categories' => 'notification_categories#delete_notification_categories'
      resources :service_histories
      post '/delete_service_histories' => 'pricings#delete_service_histories'
      post '/update_service_history_image' => 'service_histories#update_service_history_image'
      resources :default_bike_images
      post '/delete_default_bike_images' => 'pricings#delete_default_bike_images'
      resources :set_mails
      post '/delete_set_mails' => 'set_mails#delete_set_mails'
      resources :service_numbers
      post '/delete_service_numbers' => 'service_numbers#delete_service_numbers'
      resources :contact_numbers
      post '/delete_contact_numbers' => 'contact_numbers#delete_contact_numbers'
      resources :passwords, only: [:create]
      resources :dealer_contact_labels
      post '/delete_dealer_contact_labels' => 'dealer_contact_labels#delete_dealer_contact_labels'
      resources :dealer_contact_numbers
      post '/delete_dealer_contact_numbers' => 'dealer_contact_numbers#delete_dealer_contact_numbers'
      resources :contact_types
      post '/delete_contact_types' => 'contact_types#delete_contact_types'
      resources :notification_counts
      post '/delete_notification_counts' => 'notification_counts#delete_notification_counts'
      post '/create_bulk_notification' => 'notifications#create_bulk_notification'
      resources :notifications 
      post '/delete_notifications' => 'notifications#delete_notifications'
      #manual notifications
      post '/get_manual_notifications' => 'notifications#get_manual_notifications'
      #bike gallery
      resources :galleries
      post '/delete_galleries' => 'galleries#delete_galleries'
      resources :accessory_enquiries
      post '/delete_accessory_enquiries' => 'accessory_enquiries#delete_accessory_enquiries'
      #post '/get_document' => 'finance_documents#get_document'
      #versioning
      resources :version_controls
      #value added sewrvices
      resources :value_added_services
      post '/delete_value_added_services' => 'value_added_services#delete_value_added_services'
      #for booking slots
      resources :booking_slots
      post '/delete_booking_slots' => 'booking_slots#delete_booking_slots'
      get '/slot_counts' => 'booking_slots#slot_counts'

      #for admin new chnages
      resources :customer_galleries
      post '/delete_customer_galleries' => 'customer_galleries#delete_customer_galleries'
      #testmonial admin changes
      resources :testmonials
      get '/get_limit_testmonials' => 'testmonials#get_limit_testmonials'
      post '/dealer_testmoail_images' => 'testmonials#dealer_testmoail_images'
      post '/delete_testmonials' => 'testmonials#delete_testmonials'
      post '/get_brand_testmonials' => 'testmonials#get_brand_testmonials'
       #for careers
      resources :careers 
      post '/delete_careers' => 'careers#delete_careers'
      resources :web_banners
      post '/delete_web_banners' => 'web_banners#delete_web_banners'
      resources :jobs
      post '/delete_jobs' => 'jobs#delete_jobs'
      # resources :poster_form_images
      # post '/delete_poster_form_images' => 'poster_form_images#delete_poster_form_images'
      resources :web_car_galleries
      post '/delete_web_car_galleries' => 'web_car_galleries#delete_web_car_galleries'
      resources :web_display_car_images
      post '/delete_display_car_images' => 'web_display_car_images#delete_display_car_images'
      resources :web_car_colors
      post '/delete_web_car_colors' => 'web_car_colors#delete_web_car_colors'
      #for 360 degrees and you tube urls
      resources :model_full_images
      post '/delete_all_full_images' => 'model_full_images#delete_all_full_images'
      #for about us
      resources :about_us_pages
      post '/delete_about_details' => 'about_us_pages#delete_about_details'
      #for email price
      resources :email_price_lists
      #for p[rice chart
      get '/get_price_chart'  => 'email_price_lists#get_price_chart'
      post '/delete_price_lists' => 'email_price_lists#delete_price_lists'
      #for social links
      resources :social_media_links
      post '/delete_social_links' => 'social_media_links#delete_social_links'
      #  post '/get_email_price_by_brand' => 'email_price_lists#get_email_price_by_brand'
      #for whats app changes
      resources :whatsapp_chats
      post '/delete_multiple_chats' => 'whatsapp_chats#delete_multiple_chats'
      #payment chanegs and merchants
      resources :merchants
      post '/delete_merchants' => 'merchants#delete_merchants'
      resources :payments
      #resend api and cancel api changes
      post '/resend_and_cancel_payments' => 'payments#resend_and_cancel_payments'
      post '/update_payment_after_pay' => 'payments#update_payment_after_pay'
      post '/refund_payment_api' => 'payments#refund_payment_api'
      post '/mybikes_with_user' => 'payments#mybikes_with_user'
      get '/payment_bike_details' => 'payments#payment_bike_details'
      
    end
  end

## ================= Below is Mobile API Routes ================= ##

namespace :website, defaults: { format: :json }, path: '/website/' do
    # We are going to list our resources here
    #for payments
    post '/pay_split_pro' => 'payments#pay_split_pro'
    resources :payments
    get '/pay_status' => 'payments#pay_status'
    post '/get_user_due_payments' => 'users#user_due_payments_by_user_id'
    post '/get_user_completed_payments' => 'users#user_completed_payments'
    post '/pay_now' => 'payments#pay_now'

    post '/ok' => 'payments#success'
    post '/error' => 'payments#error'

    #new payment api changes
    post '/payment_submit' => 'payments#payment_submit'
    #for about us changes
    resources :about_us_pages 
    get '/get_about_us_data' => 'about_us_pages#get_about_us_data'
    get '/model_full_rotate_images' => 'about_us_pages#model_full_rotate_images'
    get '/model_video_links' => 'about_us_pages#model_video_links'
    #for used bikes
    #website new changes for data
    resources :careers 
    resources :web_banners, :only => [:index, :show]
    resources :jobs, :only => [:index, :show]
    resources :web_car_galleries
     resources :web_car_colors
    #resources :used_bikes
    #for website new changes videos and images
    resources :customer_galleries, :only => [:index, :show]
    # resources :vehicle_faqs
    #for testmonial changes
    #for website apis
    resources :testmonials
    get '/get_limit_testmonials' => 'testmonials#get_limit_testmonials'
    post '/dealer_testmoail_images' => 'testmonials#dealer_testmoail_images'
    get '/get_all_testmonial'     =>  'testmonials#get_all_testmonial'
    post '/my_cars_by_brand' => 'my_cars#my_cars_by_brand'
    # post '/destroy_all_vehicle_faqs' => 'vehicle_faqs#destroy_all_vehicle_faqs'
    # resources :used_bike_models
    # resources :used_bike_enquiries
    # get '/used_bike_filter_data' => 'used_bikes#used_bike_filter_data'
    # post '/filter' => 'used_bikes#filter'
    resources :users, :only => [:create, :show, :update, :destroy]
    post '/update_wishlist_items' => 'users#update_wishlist_items'
    post '/get_wishlist_items' => 'users#get_wishlist_items'
    post '/remove_wishlist_items' => 'users#remove_wishlist_items'
    post '/update_notifications' => 'profiles#update_notifications'
    resources :sessions, :only => [:create, :destroy]
    resources :profiles, :except => [:delete]
    post '/update_profile_image' => 'profiles#update_profile_image'

    resources :bike_types, :only => [:show, :index]
    resources :bikes, :only => [:show, :index]
    post '/bike_filter' => 'bikes#bike_filter'
    #for non bajaj vehicle data
    post '/compare_data' => 'bikes#compare_data'
    #bike compare new api
    post '/bike_compare' => 'bikes#bike_compare'
    #bike data with type
    get '/bikes_with_type' => 'bikes#bikes_with_type'
    #for email price values
    post '/email_price' => 'bikes#email_price'

    #genarate pdf reports in custom format
    post '/price_chart_pdf' => 'bikes#price_chart_pdf'
    post '/download_pdf_price_chart' => 'bikes#download_pdf_price_chart'
    get '/pdf_for_email' => 'bikes#pdf_for_email'
    #pdf eith attachemnt
    get '/pdf_url' => 'bikes#pdf_url'
    #sending email for emi data
    post '/email_emi_data' => 'bikes#email_emi_data'
    #for min and max values
    get '/min_max_values' => 'bikes#min_max_values'
    resources :specifications, :only => [:show, :index]
    resources :specification_types, :only => [:show, :index]
    resources :test_rides, :except => [:index]
    resources :service_bookings, :except => [:index]
    post '/my_bookings' => 'service_bookings#my_bookings'
    resources :my_bikes
    post '/update_my_bike_image' => 'my_bikes#update_my_bike_image'
    resources :feedbacks, only: [:create]
    resources :insurance_renewals, only: [:create, :show] 
    resources :enquiries, only: [:create]
    post '/find_book_time_controls' => 'booking_time_controls#find_book_time_controls'
    post '/book_time_control' => 'booking_time_controls#book_time_control'
    resources :my_docs
    #validate my docs
    post '/validate_my_docs' => 'my_docs#validate_document_name'
    post '/update_my_docs_image' => 'my_docs#update_my_docs_image'
    resources :dealer_types, :only => [:show]
    get '/get_dealers_with_contact_numbers' => 'dealers#dealer_contact_numbers'
    get '/get_dealer_contact_numbers_by_dealer_name' => 'dealers#get_dealer_contact_numbers_by_dealer_name'
    resources :dealers, :only => [:index, :show]
    #filter criteria for dealers
    post '/find_dealers' => 'dealers#find_dealers'
    #dealers with category
    post '/dealers_with_type' => 'dealers#dealers_with_type'
    resources :finance_documents, :only => [:show]
    resources :tenures, :only => [:index, :show]
    resources :accessory_categories, only: [:index, :show]
    post '/accessories_with_brand' => 'accessory_categories#accessories_with_brand'
    resources :set_booking_numbers, only: [:index, :show]
    post '/my_bike_service_histories' => 'service_histories#get_my_bike_service_histories'
    resources :banners, only: [:index, :show]
    resources :service_schedules, only: [:index, :show]
    post '/service_schedules_with_bike' => 'service_schedules#service_schedules_with_bike'
    post '/get_accessories' => 'accessory_categories#get_accessories'
    post '/accessories_enquiry' => 'accessory_categories#accessories_enquiry'
    resources :service_histories, :except => [:index]
    post '/validate_service_histories' => 'service_histories#validate_service_histories'
    post '/my_bike_service_histories' => 'service_histories#get_my_bike_service_histories'
    post '/service_history_image_update' => 'service_histories#service_history_image_update'
    resources :contact_numbers, only: [:index, :show]
    post '/booking_numbers_with_category' => 'contact_numbers#get_contact_numbers'
    post '/get_contact_numbers' => 'contact_numbers#get_booking_number'
    resources :passwords, only: [:create]
      # #for value added service
      # resources :value_added_services, only: [:create]
      # #Api for user nitification count
      # post '/notification_count' => 'users#notification_count'
      # post '/clear_notification_count' => 'users#clear_notification_count'
      # post '/notification_by_category' => 'users#notification_by_category'
      # resources :notifications
      # post '/mark_as_read' => 'notifications#mark_as_read'
      # post '/email_document' => 'finance_documents#email_document'
      # post '/get_document' => 'finance_documents#get_document'
      # post '/delete_notifications' => 'notifications#delete_notifications'
      #passwordpost 
      post '/update_password' => 'users#update_password'
      resources :accessories
      get '/wishlist_count' => 'users#wishlist_count'
      # post '/update_fuel' => 'my_bikes#update_fuel'
      get '/bike_with_accessories' => 'accessories#bike_with_accessories'
      post '/accessories_bike'  => 'accessories#accessories_bike'
      # resources :version_controls
      # post '/find_user_app_version' => 'version_controls#find_user_app_version'
      # post '/update_user_app_version' => 'version_controls#update_user_app_version'
    end

  end
