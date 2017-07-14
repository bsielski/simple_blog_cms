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

  Role.create! name: "can_edit_own_articlers"
  Role.create! name: "can_delete_own_articlers"
  Role.create! name: "can_edit_others'_articlers"
  Role.create! name: "can_delete_others'_articlers"

  Role.create! name: "can_create_categories"
  Role.create! name: "can_edit_categories"
  Role.create! name: "can_delete_categories"

  Role.create! name: "can_give_roles"
  Role.create! name: "can_take_away_roles"

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

## SECOND ADMIN FOR TESTS ONLY
  second = Admin.create!(
    email: "second@example.com",
    password: "qwerty",
    password_confirmation: "qwerty"
  )
  puts "A second Admin created."

  second.add_role :can_edit_own_authors
  second.add_role :can_delete_own_authors

  second_author = Author.create!(
    name: "Second",
    admin: second
  )
  puts "A second author for the second admin created."
#############################

## Editor ADMIN FOR TESTS ONLY
  editor = Admin.create!(
    email: "editor@example.com",
    password: "qwerty",
    password_confirmation: "qwerty"
  )
  puts "A editor Admin created."

  Author.create!(
    name: "Editor",
    admin: editor
  )
  editor.add_role :can_edit_own_authors
  editor.add_role :can_delete_own_authors
  editor.add_role :"can_edit_others'_authors"

  editor.add_role :"can_activate_stylesheets"

  editor.add_role :"can_create_header_sections"
  editor.add_role :"can_edit_header_sections"
  editor.add_role :"can_delete_header_sections"
  editor.add_role :"can_create_footer_sections"
  editor.add_role :"can_edit_footer_sections"
  editor.add_role :"can_delete_footer_sections"

  puts "A Editor author for the editor admin created."
#############################

  HeaderSection.create!(
    position: 1,
    content: Convert.to_html("![](https://dummyimage.com/60x55/000000/ffffff.png&text=Logo)")
  )
  puts "A header section with logo created."

  HeaderSection.create!(
    position: 2,
    content: Convert.to_html("# My Site\n\nwill be awesome soon")
  )
  puts "A header section with the site's title created."

  FooterSection.create!(
    position: 0,
    content: Convert.to_html("Copyleft #{Date.today.year}")
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
    status: 1,
    content: Convert.to_html("# Hello, World!\nThis is the first article. It was generated automatically. Delete it if you want."),
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
    name: "Default style",
    content: <<-THESTRING
    /* PAGE */

    body {
      background-color: black;
      margin: 0;
    }
    .page_container {
      max-width: 750px;
      margin: 0 auto;
      padding: 5px 20px;
      background-color: #ffffee;
    }

    /* PAGE_HEADER */

    .page_header {
      display: flex;
      flex-flow: row wrap;
    }
    .page_header__section {
      margin: 0;
      padding: 0 10px 0 0;
      display: block;
      text-decoration: none;
      color: black;
    }
    .page_header__section > h1 {
      display: block;
      font-size: 2em;
      font-weight: bold;
      margin: 0;
      padding: 0;
      font-family: 'Ubuntu', sans-serif;
    }
    .page_header__section > p {
      margin-top: 0;
      padding-top: 0;
      font-family: 'Ubuntu', sans-serif;
      margin-bottom: 1px;
      padding: 1px 0;
      margin: 0;
      display: block;
      font-size: 14px;
    }

    /* MAIN NAVIGATION */

    .main_navigation {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      margin: 0 1px;
      padding: 0;
      font-size: 14px;
    }
    .main_navigation__item {
      min-width: 150px;
      max-width: 100px;
      flex: auto;
      border: 1px solid red;
      border-radius: 0;
      margin: 2px;
      font-family: 'Ubuntu', sans-serif;
      padding: 0;
      display: flex;
      align-items: stretch;
      font-size: 14px;
    }
    .main_navigation__link {
      padding: 5px 3px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex: 1 1 auto;
      text-decoration: inherit;
      color: inherit;
      margin: 0;
      cursor: auto;
      text-align: center
    }
    .main_navigation__link--active {
      background-color: darkred;
      color: white;
      font-weight: bold;
    }

    /* PAGE_TITLE */

    .current_page_header {
      text-align: center;
    }
    .current_page_header > h1 {
      font-family: 'Ubuntu', sans-serif;
      font-size: 28px;
    }

    /* PAGINATION */

    .pagination {
      font-family: 'Ubuntu', sans-serif; }
      .pagination a, .pagination span, .pagination em {
        max-height: 18px;
        padding: 5px 10px;
        display: block;
        float: left;
        margin-right: 1px;
        border: 1px solid #ff0000;
        text-decoration: none;
        color: #000000;
    }
    .pagination .disabled {
        color: #999999;
        border: 1px solid #dddddd;
    }
    .pagination .current {
        font-style: normal;
        font-weight: bold;
        background: #8b0000;
        color: #ffffff;
    }
    .pagination a:hover, .pagination a:focus {
          color: #000000;
    }
    .pagination .page_info {
        background: #8b0000;
        color: white;
        padding: 0.4em 0.6em;
        width: 22em;
        margin-bottom: 0.3em;
        text-align: center;
    }
    .pagination .page_info b {
          color: #000000;
          background: #000000;
          padding: 0.1em 0.25em;
    }
    .pagination:after {
        content: ".";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    * html .pagination {
        height: 1%;
    }
    *:first-child + html .pagination {
        overflow: hidden;
    }

    /* ARTICLE */

    .article {
      margin: 30px 0;
      border-bottom: 2px solid rgba(150, 150, 100, 0.2);
    }

    /* ARTICLE_TITLE */

    .article_title {
      margin-bottom: 5px;
    }
    .article_title__link {
      text-decoration: none;
      color: black;
      font-size: 28px;
      font-family: 'Ubuntu', sans-serif;
      margin: 0;
    }

    /* ARTICLE_CATEGORIES */

    .article_categories {

    }
    .article_categories__title {
      font-size: 13px;
      color: #111111;
    }
    .article_categories__list {
      display: inline;
      list-style-type: none;
      margin: 0;
      padding: 0;
    }
    .article_categories__item {
      display: inline;
      margin-left: 1px;
      font-size: 13px;
    }
    .article_categories__link {
      text-decoration: underline;
      text-decoration-style: solid;
      color: #111111;
    }

    /* ARTICLE_BODY */

    .article_body {
      padding: 0;
      margin: 15px 0;
    }
    .article_body > h1 {
      margin-top: 10px ;
      margin-bottom: 10px;
      font-family: 'Ubuntu', sans-serif;
      font-size: 16px;
    }
    .article_body > h2 {
      margin-top: 10px ;
      margin-bottom: 10px;
      font-family: 'Ubuntu', sans-serif;
      font-size: 14px;
    }
    .article_body > h3 {
      margin-top: 10px ;
      margin-bottom: 10px;
      font-family: 'Ubuntu', sans-serif;
      font-size: 12px;
    }
    .article_body > p {
      margin-top: 10px;
      margin-bottom: 10px;
      font-family: 'Noticia Text', serif;
      text-align: justify;
    }

    figcaption {
      font-size: small;
      font-style: italic;
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

    /* ARTICLE_FOOTER */

    .article_footer {
      font-size: 13px;
      margin: 13px 0 13px 0;
    }
    .article_footer__created {
      margin: 3px 0 3px 0;
      display: block;
      color: #111111;
    }
    .article_footer__author {
      margin: 3px 0 3px 0;
      display: block;
      color: #111111;
    }


    /* PAGE_FOOTER */

    .page_footer {
      margin: 0;
      padding: 0;
      display: flex;
      flex-flow: row wrap;
      justify-content: space-around;
    }
    .page_footer__section {
      margin-top: 10px;
      text-align: center;
      font-style: italic;
      font-family: 'Ubuntu', sans-serif;
      width: 50%;
    }
    .page_footer__section > p {
      font-family: 'Noticia Text', serif;
      margin-top: 1px;
      margin-bottom: 1px;
      padding: 1px 0;
      display: block;
      text-align: center;
      font-style: italic;
      font-size: 14px;
    }
    .link_to_admin_panel {
      display: block;
      background-color: black;
      color: #ffffee;
      max-width: 750px;
      margin: 0 auto;
    }

THESTRING
  )
  puts "A stylesheet created."

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
    status: 1,
    content: Convert.to_html("# Hello again!\nThis is the second article. It was generated for tests."),
    url_title: "test-article",
    author: author
  )
  Article.last.categories << Category.first
  puts "A test article created."

  categories = ["Scottish Football League players", "Weather", "Movies", "Fictional Ninjutsu practitioners", "Books", "Music", "News", "Blog", "Programming", "Humor", "Contact", "The Evening Air", "All Your Base Are Belong To Us"]
  paragraphs = ["In the next season he was transferred to another Lombard club Varese, also in the same level as Pergocrema. He won promotion to Serie B with Varese in June 2010.", "It was attached to the Kiev Special Military District/Soviet Southwestern Front at the outbreak of World War II, as part of the 15th Rifle Corps, 5th Army. Under Colonel V.P. Solokov, it was earmarked to defend the mid-Volga River islands behind the hard-pressed 62nd Army on 7 October 1942. However it was deployed in the Battle of Stalingrad proper on 26 October 1942, being ferried over from the east to the west bank of the Volga River to take up positions between the Red October and the Barrikady factories.", "In October 2004, a third song from Cartañá, \"Lost Your Mind\", was due for release, however the song was cancelled two weeks prior to the due date. This would be her last piece of music to be released under the EMI label, as difficulties in decision-making towards her second solo single, would start to take artist and label, as well as her then management in different directions, also triggering uncertainty amongst all of those involved.", "It is the only surviving significant remnant of Hardyville, a once-thriving shipping port for steamboats (on the Colorado River) and had served as the county seat of Mohave County. It contains 17 graves, each covered with a pile of cobble stones, as originally created.", "Panda was born in a Utkal (Oriya) Brahmin family. His father was Devendra Nath Panda and mother Niradabala Panda. He graduated in arts from the Dantan Bhattar College, which was then affiliated with the prestigious and historic University of Calcutta.", "In his diocese he showed great severity to nonconformists, and rigidly enforced the act prohibiting conventicles. He spent a great deal of money on the restoration of the cathedrals of Worcester and Salisbury. He died at Knightsbridge on 6 January 1689.", "Kobo-chan began publication in the newspaper Yomiuri Shimbun on April 1, 1982. Beginning in December of that year, Soyosha published the series in book form. Nippon Television began airing the Kobo-chan strip on television on September 15, 1990. The weekly anime series ran on that channel from October 19, 1992, to March 21, 1994. Yomiuri had published 6,000 Kobo-chan strips by March 1999. Soyosha published Volume 60 on October 22, 2003. Houbunsha began publishing volumes on May 6, 2004. Its most recently volume, the 37th, was published on February 7, 2017.", "On 11 December 2013 Bocão signed for Avaí. He made his professional debut on 19 April of the following year, starting in a 1–3 away loss against América-RN for the Série B championship.", "Schwarzenburg District was one of the 26 administrative districts in the Canton of Bern, Switzerland. Its capital was the town of Schwarzenburg, located in the municipality of Wahlern.", "She competed at world championships, including at the 2015 World Rhythmic Gymnastics Championships where she won the bronze medal in the all-around event. She participated at the 2015 European Games in Baku.", "USS Volunteer has been the name of more than one United States Navy ship.", "In 2007, Russo won Best Director for her short, Taste of Kream, in the New Orleans Film Festival.", "Mitsuru: The main character. A young boy who befriends an apatosaurus.", "This species was described by Telford and Telford in 2003.", "When Lardé was a child, her father traveled to the United States a few times before deciding to move the family there permanently in 1944.", "Veng Sereyvuth is a Cambodian politician. He belongs to Funcinpec and was elected to represent Prey Veng Province in the National Assembly of Cambodia in 2003.", "Mimudea longipalpalis is a moth in the Crambidae family. It was described by Hampson in 1903. It is found in Kashmir.", "Mucin 3A is a protein that in humans is encoded by the MUC3A gene.", "Nonius Software is a Portuguese organization that works in the telecommunications field. Its headquarters are in Porto.", "The book collects ten novelettes and short stories by various science fiction authors.", "\"Sweet Surrender\" also did well internationally. It was a Top 10 hit in Canada (#4) and New Zealand (#7).", "The idea for the story came from the haberdashery business run by the Sallambiers on the maternal side of Balzac's family.", "Federal cooperators Michael Blutrich and Lyle Pfeffer received reduced sentences of 200 months and served their terms in the Federal Witness Security Program.", "With his father in pursuit, Schreiber and his mother were trailed by private detectives in various states; when he was three, his father kidnapped him from an upstate New York commune to which Heather had decamped.", "He also played List A cricket for Minor Counties South, first appearing for the team in the 1972 Benson & Hedges Cup against Somerset.", "The show also shows some cartoons like Kabouter Plop, Piet Piraat and Bumba.", "In geometric topology, Busemann functions are used to study the large-scale geometry of geodesics in Hadamard spaces and in particular Hadamard manifolds (simply connected complete Riemannian manifolds of nonpositive curvature).", "Margolskee’s first faculty appointment was in Neuroscience at the Roche Institute of Molecular Biology, where he also held an adjunct appointment in the Department of Biological Sciences of Columbia University.", "The tournament was hosted in Pakistan from 11 to 21 November 2014.", "In 2009 Wasiak represented Australia in Lithuanian World Games competing in women's basketball.", "The entire building is designed in typical Hundertwasser style, with wavy, undulating floors and a notable lack of straight lines.", "Quentin Aanenson Field covers an area of 85 acres (34 ha) at an elevation of 1,435 feet (437 m) above mean sea level.", "Pločnik is a village in the municipality of Ćićevac, Serbia. According to the 2002 census, the village has a population of 593 people.", "Alv Knutsson held over 276 farms in east and south Norway. He held important Norwegian fiefs including Solør and was one of the largest property holders in Norway inheriting part of the knight and Norwegian National Councilor Sigurd Jonsson’s vast properties, including Sørum the estate (Sudrheim) in Romerike and Giske estate in Sunnmøre.", "Chryseobacterium shandongense is a Gram-negative, rod-shaped, non-spore-forming and non-motile bacteria from the genus of Chryseobacterium which has been isolated from soil.", "NAF was created by philanthropist Sanford I. Weill. His proposal was accepted by the New York City Board of Education to open the first Academy of Finance in a Brooklyn public high school, John Dewey High School, in 1982.", "Between 1993 and 2004, the award voting panel comprised variously fans; sportswriters and broadcasters, sports executives, and retired sportspersons, termed collectively experts; and retired sportspersons, but balloting thereafter has been exclusively by fans over the Internet from amongst choices selected by the ESPN Select Nominating Committee.", "Composition for the Axemen is a public artwork by American sculptor Ken Wyten, located at Union Center Plaza at 840 First Street NE in Washington, D.C., United States.", "The Foro Italico is a lawn along the seafront of Palermo, Sicily, Italy.", "In 1994, he moved to the German Football League where he was the defensive coordinator of the Hamburg Blue Devils before becoming head coach of the Stuttgart Scorpions in 1996." ]
  titles = [
    "Who Else Is Lying To Us About Games?",
    "Life, Death And Games",
    "What You Don'T Know About Games May Shock You",
    "The Dirty Truth On Games",
    "The Games Trap",
    "The Low Down On Games Exposed",
    "Dirty Facts About Games Revealed",
    "What Everybody Else Does When It Comes To Computers And What You Should Do Different",
    "The Idiot's Guide To Computers Explained",
    "Unknown Facts About Computers Revealed By The Experts",
    "The Hidden Truth On Computers Exposed",
    "The Secret Of Computers That No One Is Talking About",
    "The Unexposed Secret Of Computers",
    "The Meaning Of Swords",
    "Top Tips Of Swords",
    "Top Aliens Secrets",
    "Swords Can Be Fun For Everyone",
    "Swords Options",
    "Swords Secrets",
    "What Does Swords Mean?",
    "Why Almost EveRything You'Ve Learned About Anti-Personnel Mines Is Wrong And What You Should Know",
    "Unbiased Article Reveals 5 New Things About Nuclear Warheads That Nobody Is Talking About",
    "Short Article Reveals The Undeniable Facts About Aliens And How It Can Affect You",
    "New Ideas Into Swords Never Before Revealed",
    "What You Should Do To Find Out About Guns Before You'Re Left Behind",
    "Unusual Article Uncovers The Deceptive Practices Of Aliens",
    "7 Ways To Guard Against AI",
    "The Battle Over AI Rebellion And How To Win It",
    "A Startling Fact About Tanks Uncovered",
    "The Foolproof Nuclear Warheads",
    "Things You Won'T Like About Generators And Things You Will",
    "The Ulitmate Strategy Trick",
    "The Tried And True Method For Generators In Step By Step Detail",
    "The Honest To Goodness Truth On Generators",
    "The Number One Question You Must Ask For Generators",
    "Robots - Dead Or Alive?",
    "Who Else Wants To Learn About Generators?",
    "The Chronicles Of Robots",
    "Understanding Universe",
    "Universe Help!",
    "Discover What Universe Is",
    "Choosing Good Universe",
    "Choosing Universe",
    "Choosing Universe Is Simple",
    "Finding The Best Universe",
    "How To Choose Universe",
    "Introducing Universe",
    "The Most Popular Universe",
    "Top Choices Of Universe",
    "Top Guide Of Universe",
    "Top Universe Reviews!",
    "Top Universe Tips!",
    "Universe Reviews & Guide",
    "Top Life Guide!",
    "The Key To Successful Life",
    "What Makes A Life?",
    "Buying Life",
    "How To Get A Life?",
    "Purchasing Life",
    "What Is So Fascinating About Life?",
    "Top Life Choices",
    "Finding Life",
    "Life : The Ultimate Convenience!",
    "Life Features",
    "The Basic Of Life",
    "Life Ideas",
    "Characteristics Of Life",
    "Definitions Of Life",
    "How To Find Life Online",
    "The Appeal Of Life",
    "The Hidden Gem Of Life",
    "The Meaning Of life",
     ]

  headers = [
    "# Plot\n\n",
    "# Cast\n\n",
    "# Preservation status\n\n",
    "# Early history\n\n",
    "# Etymology\n\n",
    "# Description\n\n",
    "# Earliest References\n\n",
    "# Residents of Turnhurst\n\n",
    "# James Brindley\n\n",
    "# Demise of Turnhurst Hall\n\n",
    "# Brindley's Lock\n\n",
    "# Turnhurst today\n\n",
    "# Medalists\n\n",
    "# Results\n\n",
    "# Final\n\n",
    "# Qualification\n\n",
    "# Creators of Batman\n\n",
    "# Notable contributors\n\n",
    "# Writers\n\n",
    "# Artists\n\n",
    "# Other notable contributors\n\n",
    "# Summary\n\n",
    "# Settings\n\n",
    "# Characters\n\n",
    "# Sequel\n\n",
    "# Awards\n\n",
    "# Biography\n\n",
    "# Political career\n\n",
    "# Post Political career\n\n",
    "# Election results\n\n",
    "# Exhibitions, Films and Workshops\n\n",
    "# Jazz musicians at Ipswich Jazz Festival\n\n",
    "# 2015\n\n",
    "# Big names\n\n",
    "# Local Musicians\n\n",
    "# Etymology\n\n",
    "# Goddess of Children\n\n",
    "# See also\n\n",
    "# References\n\n",
    "# External links\n\n",
    "# Bibliography\n\n",
    "# Hockey career\n\n",
    "# Career statistics\n\n",
    "# Coaching record\n\n",
    "# Mandals\n\n",
    "# Election results\n\n",
    "# Telangana Legislative Assembly election, 2014\n\n",
    "# Services and programs\n\n",
    "# Facility\n\n",
    "# History\n\n",
    "# Early life\n\n",
    "# Career\n\n",
    "# Awards\n\n",
    "# Selected bibliography\n\n",
    "# Origin of the concept\n\n",
    "# Chronology\n\n",
    "# Tactics\n\n",
    "# Linear tactics\n\n",
    "# Trace Italienne\n\n",
    "# The infantry revolution and the decline of cavalry\n\n",
    "# Size of armies\n\n",
    "# Administrative sources\n\n",
    "# Narrative sources\n\n",
    "# Size of overall armies\n\n",
    "# Size of field armies\n\n",
    "# Conclusion\n\n",
    "# Notes\n\n",
    "# References\n\n",
    "# Further reading\n\n",
    "# Overview\n\n",
    "# History\n\n",
    "# Ownership\n\n",
    "# Branch network\n\n",
    "# Governance\n\n",
    "# Ducal palace\n\n",
    "# From home of a parliamentarian to home of a parliament\n\n",
    "# RDS headquarters 1815–1922\n\n",
    "# Oireachtas from 1922\n\n",
    "# Extensions\n\n",
    "# Safety in the building\n\n",
  ]

  paragraphs.map!{|paragraph| paragraph + "\n\n" }

  rng = Random.new(3)
  categories.each do |category|
    Category.create!(
      name: category,
      description: "Automatically generated category for tests",
      privacy: [0, 0, 1].sample(random: rng),
    )
    puts "A default category created."
  end

  articles = []

  50.times do |i|
    article_content = ""
    how_long_article = [3,4,5,6,7,8,9,5,6,7,10].sample(random: rng)
    old_what = nil

    how_long_article.times do |i|
      if old_what == headers or i+1 == how_long_article
        what = paragraphs
      else
        what = [paragraphs, paragraphs, headers].sample(random: rng)
      end
      article_content += what.sample(random: rng)
      old_what = what
    end

    article_title = titles.sample(random: rng)

    article = { title: article_title,
                content: Convert.to_html(article_content),
                url_title: article_title.parameterize,
                author: author
              }

    articles << article

  end
  Article.create! articles
  puts "Articles created"

  categorizations = []

  Article.all.each do |article|
    how_many_categories = [1,1,1,2,3].sample(random: rng)
    article_categories = Category.all.sample(how_many_categories, random: rng)
    article_categories.each do |category|
      categorizations << {category: category, article: article}
    end
  end
  Categorization.create! categorizations

  Article.all.each do |article|
    fake_time = Time.at(rng.rand(1.year.ago.to_i..Time.now.to_i))
    article.update_columns created_at: fake_time, status: [0,1,1,1,1].sample(random: rng)
    if article.published?
      article.update_columns published_at: fake_time + 10.minutes
    end
  end


  # end testing



else
  puts "The database is not empty. Nothing was seeded."
end
