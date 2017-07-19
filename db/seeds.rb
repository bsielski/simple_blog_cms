unless Admin.first # because the db must be empty
  puts "-----------------------------------------\n \
Type your EMAIL for super admin. It will not be use for verification \
and it can be changed anytime. It has to have a proper email format."
  admin_login = STDIN.gets.chomp
  puts "Type your PASSWORD for super admin. It must be at least 6 characters long. It can be changed anytime, \
so it don't have to be super-strong, especially if you want just play and test this CMS."
  admin_password = STDIN.gets.chomp

  puts "Creating roles..."
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

  puts "Creating the super admin..."
  admin = Admin.create!(
    email: admin_login,
    password: admin_password,
    password_confirmation: admin_password
  )
  admin.add_role :super_admin
  author = Author.create!(
    name: "Admin",
    admin: admin
  )

  puts "Creating the page headers..."
  HeaderSection.create!(
    position: 1,
    content: Convert.to_html("![](https://dummyimage.com/60x55/000000/ffffff.png&text=Logo)")
  )
  HeaderSection.create!(
    position: 2,
    content: Convert.to_html("# A demo blog\n\nto demonstrate Simple Blog CMS")
  )

  puts "Creating the page footers..."
  FooterSection.create!(
    position: 1,
    content: Convert.to_html("Powered by Simple Blog CMS (betha)\n\nwhich is powered by Ruby on Rails")
  )

  puts "Creating some categories..."
  Category.create!(
    name: "Life",
    description: "An articles about biological and artificial life",
    visibility: "visible",
  )
  Category.create!(
    name: "The Universe",
    description: "An articles about physics and space.",
    visibility: "visible",
  )
  Category.create!(
    name: "Everything",
    description: "An articles about philosophy.",
    visibility: "visible",
  )
  Category.create!(
    name: "The Manual",
    description: "How to use this blog.",
    visibility: "visible",
  )

  puts "Create default articles..."
  Article.create!(
    title: "Welcome",
    content: Convert.to_html(<<-THESTRING
# Hello, Admin!

This is a demo of the betha version of a blog CMS called "Simple Blog CMS".

1. Add go to the [/admin](/admin) subpage and login.
2. Read more articles from []“The Manual”](/category/4/articles) category.
THESTRING
  ),
    url_title: "welcome",
    author: author
  ).published!
  Categorization.create!(
    category_id: 4,
    article: Article.last
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
    article: Article.last
  )

  puts "Create the default stylesheet..."
  Stylesheet.create!(
    name: "Default style",
    content: Stylesheet::DefaultStylesheet.content
  )

  puts "Create the default site settings..."
  Site.create!(
    title: "Simple Blog CMS",
    author: "",
    keywords: "CMS",
    description: "A demo of the betha version of a blog CMS called \"Simple Blog CMS\".",
    stylesheet: Stylesheet.first
  )

  answer = nil
  until answer == "y" or answer == "n"
    puts "-------------------------------------"
    puts "Create a testing stuff (more admins, categories, articles)? (y/n)"
    answer = STDIN.gets.chomp
  end
  if answer == "y"
    ##### TEST STUFF
    ## SECOND ADMIN FOR TESTS ONLY
      second = Admin.create!(
        email: "second@example.com",
        password: "qwerty",
        password_confirmation: "qwerty"
      )
      second.add_role :can_edit_own_authors
      second.add_role :can_delete_own_authors
      second_author = Author.create!(
        name: "Second",
        admin: second
      )
    ## Editor ADMIN FOR TESTS ONLY
      editor = Admin.create!(
        email: "editor@example.com",
        password: "qwerty",
        password_confirmation: "qwerty"
      )
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
    #############################
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
          visibility: [0, 0, 1].sample(random: rng),
        )
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
    puts "Testing stuff created."
    # end testing
  else
    puts "Testing stuff is not created."
  end

else
  puts "The database is not empty. Nothing was seeded."
end
