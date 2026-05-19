// Copyright 2024 Felix Schladt https://github.com/FelixSchladt

#import "colors.typ": *

#let titlepage(
  title: "Title",
  subtitle: "Subtitle",
  authors: "Authors",
  logo: none,
  logo-dimensions: (auto, auto),
  text-size: 12pt,
  date: datetime.today(),
) = {
  v(30pt)

  align(center)[
    #image("assets/HM_Logo_RGB.png", width: 30%)
    #v(40pt)
    #text(title, size: 24pt, weight: "bold", fill: hm-black)
    #linebreak()
    #v(1pt)
    #text(subtitle, size: 15pt, weight: "semibold")
    #v(0pt)
    #text(authors, size: 15pt)
    #v(0pt)
    #text(date.display("[day]. [month repr:long] [year]"), size: 15pt)
    #v(30pt)
  ]

  pagebreak()
}
