# coding: utf-8
class Stylesheet::DefaultStylesheet

  def self.content
<<-THESTRING
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
  cursor: pointer;
  text-align: center;
}
.main_navigation__link--active {
  background-color: darkred;
  color: white;
  font-weight: bold;
}

/* PAGE_TITLE */

.current_page_header {
  text-align: center;
  color: #8b0000;
  font-size: 32px;
  font-family: 'Ubuntu', sans-serif;
  padding-bottom: 15px;
  border-bottom: 1px solid #8b0000;
}

/* PAGINATION */

.pagination {
  font-family: 'Ubuntu', sans-serif;
}
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
  text-align: center;
  margin-bottom: 5px;
}
.article_title__link {
  text-decoration: none;
  color: black;
  font-size: 30px;
  font-family: 'Ubuntu', sans-serif;
  margin: 0;
}

/* ARTICLE_CATEGORIES */

.article_categories {

}
.article_categories__title {
  font-size: 15px;
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
  font-size: 14px;
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
  margin-top: 10px;
  margin-left: 0;
  margin-bottom: 10px;
  font-family: 'Ubuntu', sans-serif;
  font-size: 18px;
}
.article_body > h2 {
  margin-top: 10px;
  margin-left: 0;
  margin-bottom: 10px;
  font-family: 'Ubuntu', sans-serif;
  font-weight: normal;
  font-size: 18px;
}
.article_body > h2:before {
  content: "● ";
}
.article_body > h3 {
  margin-top: 10px;
  margin-left: 0;
  margin-bottom: 10px;
  font-family: 'Ubuntu', sans-serif;
  font-weight: normal;
  font-size: 18px;
}
.article_body > h3:before {
  content: "○ ○ ";
}
.article_body > h4 {
  margin-top: 10px;
  margin-left: 0;
  margin-bottom: 10px;
  font-family: 'Ubuntu', sans-serif;
  font-weight: normal;
  font-style: oblique;
  font-size: 18px;
}
.article_body > h4:before {
  content: "– – – ";
}
.article_body > p {
  margin-top: 10px;
  margin-bottom: 10px;
  font-family: 'Noticia Text', serif;
  text-align: justify;
  text-indent: 10px;
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
.article_body > code {
  /*border: 2px solid grey;*/
  padding: 2px 3px;
  /*margin: 5px;*/
  display: inline;
  background-color: #222222;
  color: #dddddd;
  font-weight: bold;
}
.article_body > pre {
  overflow: auto;
}
.article_body > pre > code {
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
  display: flex;
  flex-flow: column;
  align-items: flex-start;
}
.article_footer__created {
  margin: 3px 0 3px 0;
  color: #111111;
}
.article_footer__published {
  margin: 3px 0 3px 0;
  color: #111111;
}
.article_footer__author {
  margin: 3px 0 3px 0;
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

  end

end
