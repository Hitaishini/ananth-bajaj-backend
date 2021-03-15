class Web::V1::NotificationCountSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :test_drive_count, :offer_count, :insurance_count, :service_count
end
