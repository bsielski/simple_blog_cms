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
    content: <<-THESTRING
* {
  padding: 0;
  margin: 0;
  /*border: 1px dashed lightgrey;
  border-radius: 10px;*/
}
main > header > h1 {
  margin-bottom: 10px;
}
body > div > footer {
  margin-top: 10px;
}

main > article {
  margin: 30px 0;
}

article > header {
  margin-bottom: 15px;
}

article > section {
  padding: 15px 0;
  margin: 0 0;
  border-top: 2px solid rgba(150, 150, 100, 0.2);
}
article > section:last-child {
  border-bottom: 3px solid rgba(150, 150, 100, 0.2);
}

body {
  background-color: #050500;
  font-size: 14px;
}
li {
   list-style-position: inside;
}
a {
  text-decoration: inherit;
  color: inherit;
}
h1, h2, h3, h4, h5, h6 {
  font-family: 'Ubuntu', sans-serif;
}
figcaption {
  font-size: small;
  font-style: italic;
}
p {
  font-family: 'Noticia Text', serif;
  margin-top: 1px;
  margin-bottom: 1px;
  padding: 1px 0;
}
code {
  /*background-color: lightgrey;*/
  border: 1px solid #d0d0b0;
  font-size: smaller;
  padding-left: 2px;
  padding-right: 2px;
}

code {
  /*border: 2px solid grey;*/
  padding: 2px 3px;
  /*margin: 5px;*/
  display: inline;
  background-color: #222222;
  color: #dddddd;
  font-weight: bold;
}
pre > code {
  border: 5px solid #3c4049;
  padding: 3px 7px;
  margin: 1px 0px;;
  display: inline-block;
  background-color: #282c34;
  color: #92a5b1;
}

body > div {
  max-width: 750px;
  margin: 0 auto;
  padding: 5px 20px;
  /*border: 2px solid blue;
  border-radius: 0;*/
  background-color: #ffffee;

}
body > div > header > h2 {
  margin-top: 0;
  padding-top: 0;
  /*border: 1px solid red;
  border-radius: 0;*/
  font-family: 'Ubuntu', sans-serif;
}
body > div > header > h1 {
  margin: 0;
  padding: 0;
  /*border: 1px solid orange;
  border-radius: 0;*/
  font-family: 'Ubuntu', sans-serif;
}
body > div > nav {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  margin: 0 1px;
  /*border: 1px solid orange;
  border-radius: 0;*/
}
body > div > nav > div {
  min-width: 150px;
  max-width: 100px;
  flex: auto;
  border: 1px solid red;
  border-radius: 0;
  text-align: center;
  margin: 2px;
  font-family: 'Ubuntu', sans-serif;
}
body > div > nav > div > a {
  padding: 5px 3px;

  display: block;
}
body > div > nav > div > a > em, body > div > nav > div a:active {
  background-color: darkred;
  color: white;
  font-weight: bold;
}

body > div > nav > div > small {
  background-color: grey;
  color: #aaaaaa;
  pointer-events: none;
  cursor: default;
}

body > div > footer {
  text-align: center;
  font-style: italic;
  /*border: 1px solid red;
  border-radius: 0;*/
  font-family: 'Ubuntu', sans-serif;
}
main > header {
  text-align: center;
}
THESTRING
             
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
