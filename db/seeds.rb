# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


Store.create([{ :name => "Carl's Jr", :street_1 => "123 Carls Street", :city => "Carl's City", :state => "Carlifornia", :zipcode => "12345"},
			  { :name => "Jack in the box", :street_1 => "123 Jack Street", :city => "Jack City", :state => "Jackifornia", :zipcode => "12345"},
			  {:name => "Fuddruckers", :street_1 => "123 Fudd Street", :city => "Fudds City", :state => "Fuddifornia", :zipcode => "12345"}, 
			  {:name => "Starbucks", :street_1 => "123 Star Street", :city => "Star City", :state => "Starifornia", :zipcode => "12345"},
			  {:name => "Burger King", :street_1 => "123 Burger Street", :city => "Burger City", :state => "Burgerfornia", :zipcode => "12345"}])