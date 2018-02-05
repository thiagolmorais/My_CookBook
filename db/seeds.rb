# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(username: 'Thiago', email: 'user1@bol.com',
                   password: '123456', city: 'Praia Grande',
                   facebook: 'https://www.facebook.com/',
                   twitter: 'https://www.twitter.com/')

brasileira = Cuisine.create(name: 'Brasileira')
arabe = Cuisine.create(name: 'Arabe')

sobremesa = RecipeType.create(name: 'Sobremesa')
entrada= RecipeType.create(name: 'Entrada')

tabule = Recipe.create(title: 'Tabule', cuisine: arabe, recipe_type: entrada,
                       difficulty: 'Fácil', cook_time: 45, people_serve: '4',
                       ingredients: 'Trigo, cebola, azeite, salsinha',
                       method: 'Misturar tudo e servir. Adicione limão.', user: user,
                       image_file_name: "tabule.jpg", featured: true)



bolo_cenoura = Recipe.create(title: 'Bolo de cenoura', cuisine: brasileira, recipe_type: sobremesa,
                             difficulty: 'Médio', cook_time: 60, people_serve: '4',
                             ingredients: 'Cenoura, acucar, oleo e chocolate',
                             method: 'Misturar tudo, bater e assar', user: user,
                             image_file_name: "bolo_cenoura.jpg", featured: false)

Favorite.create(user: user, recipe: bolo_cenoura)
