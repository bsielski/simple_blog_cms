# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

default_login = "admin@example.com"
default_password = "qwerty"

unless Admin.first

  admin = Admin.create!(
    email: default_login,
    password: default_password,
    password_confirmation: default_password
  )
  puts "A default Admin created. Login: #{default_login}, password: #{default_password}"

  author = Author.create!(
    name: "Admin",
    admin: admin
  )
  puts "A default author for the admin created."

  HeaderSection.create!(
    position: 0,
    content: "# My Site\n\n## will be awsome soon"
  )
  puts "A default header created."

  FooterSection.create!(
    position: 0,
    content: "Copyleft #{Date.today.year}"
  )
  puts "A default footer created."

  Category.create!(
    name: "Home",
    description: "The \"main\" starting page",
    privacy: 0,
    position: 0,
  )
  puts "A default category created."

  Article.create!(
    title: "Welcome",
    privacy: 0,
    content: "# Hello, World!\nThis is the first article. It was generated automatically. Delete it if you want.",
    url_title: "welcome",
    author: author
  )
  puts "A default article created."

  Categorization.create!(
    category: Category.first,
    article: Article.first
  )
  puts "Categorization done."
  
  Stylesheet.create!(
    content: ""
  )
  puts "An empty stylesheet created."
  
  Site.create!(
    title: "My Site",
    author: "",
    keywords: "",
    description: "",
    stylesheet: Stylesheet.first
  )
  puts "Site atributes created."
  

  # obejcts for tests. They will be deleted
  # begin testing
  Article.create!(
    title: "The Second",
    privacy: 0,
    content: "# Hello again!\nThis is the second article. It was generated for tests.",
    url_title: "test-article",
    author: author
  )
  Article.last.categories << Category.first
  puts "A test article created."
  # end testing
  

  
else
  puts "The database is not empty. Nothing was seeded."
end
