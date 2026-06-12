// Copyright 2024 Danny Seidel https://github.com/DannySeidel
// Copyright 2025 Felix Schladt https://github.com/FelixSchladt

#import "@preview/linguify:0.5.0": *
#import "@preview/oxifmt:1.0.0": strfmt

#import "../lang.typ": *

#import "stringify.typ": *

#let make-declaration-of-authorship(
  authors,
  doc-type,
  title,
  date,
  language,
  city,
  date-format,
  signature-img,
) = {
  if (doc-type == none) {
    panic("Declaration of authorship requires doc-type to be set!")
  }
  if (title == none) {
    panic("Declaration of authorship requires title to be set!")
  }
  if (city == none) {
    panic("Declaration of authorship requires city to be set")
  }

  v(2em)
  heading(
    level: 1,
    linguify(
      "lib_declaration_of_authorship-title",
      from: lang-db
      )
  )

  v(1em)

  par(
    justify: true,
    strfmt(
      linguify-raw(
        "lib_declaration_of_authorship-body-0",
        from: lang-db,
        lang: language,
      ),
      lower(doc-type)
    )
  )
  v(1em)
  align(center,
    text(weight: "bold", title)
  )
  v(1em)
  par(
    justify: true,
    linguify("lib_declaration_of_authorship-body-1", from: lang-db),
  )

  let end-date = if (type(date) == datetime) {
    date
  } else {
    date.at(1)
  }

  v(2em)
  text([#city, #end-date.display(date-format)])
  if (signature-img != none) {
    place(
      dx: 40pt,
      dy: 10pt,
      signature-img,
    )
  }

  v(1em)

  v(4em)
  line(length: 40%)
  authors
}