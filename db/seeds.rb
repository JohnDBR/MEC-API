# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#User
User.create(
	username:"admin", 
	password:"godmode01", 
	emails:"john-brs@hotmail.com, theleisser1@gmail.com",
    phones:"3128898938, 3106315237, 3332221111",
    address:"calle 76B # 42F - 122"
	) #Admin

#Token
t = Token.create(
	secret:"cd7f27e1bbfa4ca4959fbb3dbcc6c3fb", 
	expire_at:"2018-04-20", 
	user_id: 1
	)
t.update_attribute(:secret, "cd7f27e1bbfa4ca4959fbb3dbcc6c3fb") #Admin

#Carousel
# Carousel.create(
# 	name:"Carrusel Inicial"
# 	)
