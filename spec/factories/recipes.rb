FactoryBot.define do
  factory :recipe do
    title 'Bolo de cenoura'
    recipe_type
    cuisine
    difficulty 'Médio'
    ingredients 'Cenoura, acucar, oleo e chocolate'
    add_attribute(:method) { 'Misturar tudo, bater e assar' }
    cook_time 60
    user
  end
end
