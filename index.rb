# def saySomething()
#     puts "Hello World"
# end

# saySomething()


# def multiply(val1,val2)
#     result = val1 * val2
#     puts result
# end

# multiply(10,30)
# multiply(40,5)
# multiply(20,70)

# def displayStrings(*args)
#     args.each{ |string| puts string}
# end

# displayStrings("Valary","Wendy","Joyce","Stephanie","Zakiya")


# def multiplyNumbers(val1,val2)
#     multiple = val1 * val2
#     return multiple
# end

# value = multiplyNumbers(100,100)
# puts value

# puts (1..10).to_a

# (2..8).each do |num|
#     puts num
# end

# puts (0..10).step(2).to_a

# puts (0..50).first(5).inspect

# puts (0..50).last(5).inspect

# puts ('a'..'l').to_a

# puts ('Val'..'Joyce').min

# words = 'cab'..'car'

# words.each{ |word| puts 'Hello' + " "+ word }

# words.reject{ |subrange| subrange < 'cal' }


# while input = gets
#     puts input + " triggered" if input =~ /start/ .. input =~ /end/
# end

#Does the number fit in the range 1 to 20
# (1..20) === 15

# score = 90

# result = case score
#     when 0..40
#          "Fail"
#     when 41..60
#          "Pass"
#     when 61..70
#          "Pass With Merit"
#     when 71..100
#          "Pass with Distinction"

# else "Invalid Score"
#     puts result
# end


# SITES = {
#     "Kenya" => "Nairobi",
#     "USA" => "L.A"
# }

# SITES[country]


# def === (value)
#     include?(value)
# end


# Creating Objects

class Restaurant
    attr_accessor :name

    # a class variable to keep track of all class instances created
    @@all = []

    def initialize(name)
        @name = name

        #push each instance to the all array
        @@all << self
    end

    def self.all
        @@all
    end

    #####Restaurant class
    ##Restaurant.find_by_name(name)
    #returns the first restaurant that matches the name

    def find_by_name(name)
        restaurant = self.all.find{ |r|r.name == name }
        restaurant.name
    end

    ######Methods for restaurant
    def reviews
        Review.all.select { |r| r.restaurant = self }

    end

    #Restaurant#customers
    #returns a list of all customers who reviewd a restaurant
    def customers
        reviews.map{ |reviewer| reviewer.customer }.uniq

    end

    #Restaurant##average_star_rating
    #returns the average star rating of a restaurant based on it's review
    def average_star_rating
        number = reviews.count
        total = reviews.reduce(0){ |sum, r| sum += r.rating }
        average = total/number
    end

    #Restaurant#longest_review
    def longest_review
        content = reviews.map{ |r| r.content }
        content.max_by(&:lenght)
    end
    

end

class Customer
    attr_accessor :first_name, :last_name
    @@all = []

    def initialize(name)
        name = name.split()
        @first_name = name[0]
        @last_name = name[1]
        @@all << self
    end
    
    def self.all
        @@all
    end

    def full_name
        puts "#{@first_name}  #{@last_name}"
    end

    #Customer#add_review
    def add_review( rating, restaurant, content)
        Review.new(content: content, rating: rating, restaurant: restaurant, customer: self)

    end

    #Customer#num_of_reviews
    def reviews_by_user
        Review.all.select{ |reviews| reviews.customer = self }
    end

    def num_reviews
        reviews_by_user.count 
    end

    # All restaurants a customer reviewd
    def reviews
        reviews_by_user.map{ |res| res.restaurant }.uniq

    end
    
    #Customer#find_by_name
    def self.find_by_name(name)
        customer = self.all.find{ |n| n.full_name.include?(name) }
        customer.full_name
    end

    #Customer#find_by_first_name
    #given a string of first names, returns an array containing all the customers with the first name
    def self.find_by_first_name(name)
        customer = self.all.find_all{ |n| n.full_name.starts_with?(name) }
    end

    #Customer#all_names
    # should return an array with full names of customers
    def self.all_names
        self.all.map{ |customer| customer.full_name }
    end

    def restaurants
        reviews_by_user.map{ |res| res.restaurant }.uniq
    end

end

class Review
    attr_accessor :content, :restaurant, :customer
    attr_reader :rating
    @@all = []


    def initialize ( content:, restaurant:, customer:, rating:)
        @rating = rating
        @content = content
        @restaurant = restaurant
        @customer = customer
        @@all << self
    end

    def self.all
        @@all
    end

    #Review#rating
    #Return the start rating for a restaurant. Should be an integer from 1-5
    def rating=(the_rating)
        @rating = the_rating.clamp(1-5)
    end


end


#Test Data
cus1 = Customer.new("Valary Uhuru")
cus2 = Customer.new("Zakiya Mustapha")

res1 = Restaurant.new("KFC")
res2 = Restaurant.new("Burger King")

rev1= cus1.add_review("Oh woow",5, res1)
rev2 = cus2.add_review("Yummy",4, res2)
rev3 = cus1.add_review("oooh my!!",4, res1)


cus1.num_reviews
cus2.num_reviews
cus2.restaurants
cus1.restaurants

res1.customers
res1.reviews
res1.average_star_rating
res1.longest_review
res2.customers
res2.reviews
res2.average_star_rating
res2.longest_review

Customer.find_by_name("Valary Uhuru")
Customer.find_all("Valary")
Customer.all_names

Restaurant.find_by_name("KFC")
rev1.content




























