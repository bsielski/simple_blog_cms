# coding: utf-8
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

  Role.create! name: "super_admin"

  Role.create! name: "can_edit_site_settings"

  Role.create! name: "can_activate_stylesheets"

  Role.create! name: "can_create_stylesheets"
  Role.create! name: "can_edit_stylesheets"
  Role.create! name: "can_delete_stylesheets"

  Role.create! name: "can_create_header_sections"
  Role.create! name: "can_edit_header_sections"
  Role.create! name: "can_delete_header_sections"
  Role.create! name: "can_create_footer_sections"
  Role.create! name: "can_edit_footer_sections"
  Role.create! name: "can_delete_footer_sections"

  Role.create! name: "can_read_others'_unpublished_articles"

  Role.create! name: "can_create_articles"

  Role.create! name: "can_publish_own_articles"
  Role.create! name: "can_unpublish_own_articles"
  Role.create! name: "can_publish_others'_articles"
  Role.create! name: "can_unpublish_others'_articles"

  Role.create! name: "can_edit_own_articles"
  Role.create! name: "can_delete_own_articles"
  Role.create! name: "can_edit_others'_articles"
  Role.create! name: "can_delete_others'_articles"

  Role.create! name: "can_create_categories"
  Role.create! name: "can_edit_categories"
  Role.create! name: "can_delete_categories"

  Role.create! name: "can_give_roles"
  Role.create! name: "can_take_away_roles"

  Role.create! name: "can_edit_admins'_emails"
  Role.create! name: "can_delete_admins"

  Role.create! name: "can_create_own_authors"
  Role.create! name: "can_edit_own_authors"
  Role.create! name: "can_delete_own_authors"
  Role.create! name: "can_edit_others'_authors"
  Role.create! name: "can_delete_others'_authors"

  admin = Admin.create!(
    email: default_login,
    password: default_password,
    password_confirmation: default_password
  )
  puts "A default Admin created. Login: #{default_login}, password: #{default_password}"

  admin.add_role :super_admin

  author = Author.create!(
    name: "Admin",
    admin: admin
  )
  puts "A default author for the admin created."

  HeaderSection.create!(
    position: 1,
    content: Convert.to_html("![](https://dummyimage.com/60x55/000000/ffffff.png&text=Logo)")
  )
  puts "A header section with logo created."

  HeaderSection.create!(
    position: 2,
    content: Convert.to_html("# A demo blog\n\nto demonstrate Simple Blog CMS")
  )
  puts "A header section with the site's title created."

  FooterSection.create!(
    position: 1,
    content: Convert.to_html("Powered by Simple Blog CMS (betha)\n\nwhich is powered by Ruby on Rails")
  )

  puts "A default footers created."


  Category.create!(
    name: "Life",
    description: "An articles about biological and artificial life",
    visibility: "visible",
    #position: 0,
  )
  Category.create!(
    name: "The Universe",
    description: "An articles about physics and space.",
    visibility: "visible",
    #position: 0,
  )
  Category.create!(
    name: "Everything",
    description: "An articles about philosophy.",
    visibility: "visible",
  )
  Category.create!(
    name: "About this blog",
    description: "An articles about his blog. Its functions, authors, changes, plans, etc.",
    visibility: "visible",
  )

  puts "A default categories created."

  Article.create!(
    title: "Welcome",
    content: Convert.to_html(<<-THESTRING

# Hello, Admin!

This is a demo of the betha version of a blog CMS called "Simple Blog CMS".

1. Add go to the [/admin](/admin) subpage and login. The login is: “admin@example.com” and password is: “qwerty”.
2. In the Admin Panel choose “Manage articles”, find articles with “The Manual” and read them.

THESTRING
  ),
    url_title: "welcome",
    author: author
  ).published!

  Categorization.create!(
    category_id: 4,
    article: Article.first
  )

  Article.create!(
    title: "About the Admin Panel",
    content: Convert.to_html(<<-THESTRING

# The most important page

The most important page is the [/admin](/admin) page. It is used to access log-in page and the Admin Panel page.

# Admin Panel sub-sections

## Create a new category

- **Name** - displayed name.
- **Description** - not used to anything important. It can be threated as a note about the category use.
- **Visibility** - is the category visible in the main menu or not.
- **Position** - position in the main menu.

## Manage categories

It displays all categoies, visible and invisible. If an admin has a proper role (permissions)
then it can edit or delete categories. Deleting a category doesn't delete articles in that category.

## Create a new article

- **Title** - the article title.
- **Author** - it is bugged now. It shouldn';'t be possible to choose an author that doesn't belong to you.
- **Content** - it should be wrote in [Markdown](https://en.wikipedia.org/wiki/Markdown) language.
- **Categories** - each article can belong to zero, one or many categories.

Articles are not published automatically after saving. They needs to be published manually.

Articles can be in one of the two states: published or unpublished (never published or withdrawn).
Not logged users can see only published articles.

## Manage articles

Pretty same as "Manage categories" but about articles.

## My account options

Here you can change your email or password. It is possible to delete your account too.

## Logout

Sign out. You don;t have to logout just for checking how the regular users see the site.
The admin see the regular pages (without /admin/ in the address) same as not logged user.
The only dofference is the admin footer at the very bottom.

## All accounts

Lorem ipsum

## Manage authors

Lorem ipsum

## Manage styles

Lorem ipsum

## Site settings

Lorem ipsum

## Page header

Lorem ipsum

## Page footer

THESTRING
  ),
    url_title: "about-the-admin-panel",
    author: author
  ).published!

  Categorization.create!(
    category_id: 4,
    article_id: 2
  )
  answer = nil
  until answer == "y" or answer == "n"
    puts "----------------"
    puts "Create a default style? (y/n)"
    answer = STDIN.gets.chomp
  end
  if answer == "y"
    Stylesheet.create!(
      name: "Default style",
      content: Stylesheet::DefaultStylesheet.content
    )
  else
    Stylesheet.create!(
      name: "Default style",
      content: ""
    )
  end

  puts "A stylesheet created."

  Site.create!(
    title: "Simple Blog CMS",
    author: "",
    keywords: "CMS",
    description: "A demo of the betha version of a blog CMS called \"Simple Blog CMS\".",
    stylesheet: Stylesheet.first
  )
  puts "Site atributes created."

else
  puts "The database is not empty. Nothing was seeded."
end
