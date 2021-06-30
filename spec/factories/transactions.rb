FactoryBot.define do
  factory :transaction do
    invoice_id { association :invoice }
    result { 'success' }
  end
end
