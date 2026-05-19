// Copyright 2024 Danny Seidel https://github.com/DannySeidel
// Copyright 2025 Felix Schladt https://github.com/FelixSchladt
// Copyright 2026 Marcel Hofmann <marcel@hofmania.de> https://sr.ht/~marcelhfm

#import "imports.typ": *

#let std-bibliography = bibliography

#let hm-template(
  title: none,
  subtitle: none,
  doc-type: none,
  top-remark: none,
  show-table-of-contents: true,
  toc-pagebreak: false,
  toc-depth: 2,
  appendix: none,
  language: "de",
  glossary: none,
  bibliography: none,
  bib-style: "ieee",
  font: "CMU Serif",
  version: "0.1",
  authors: "",
  date: datetime.today(),
  project-logo: none,
  project-logo-dimensions: (auto, auto),
  titlepage-logo: none,
  titlepage-logo-dimensions: (auto, auto),
  chapter-heading-pagebreak: true,
  lastpage: none,
  text-size: 12pt,
  front-numbering: "i",
  main-numbering: "1 / 1",
  back-numbering: "i",
  appendix-numbering: "a / a",
  body,
) = {
  // Page Numbering
  set page(numbering: none)

  // Setup glossary
  show: make-glossary
  if glossary != none {
    register-glossary(glossary)
  }

  // Default to subtitle but enable manual setting
  if top-remark == none {
    top-remark = subtitle
  }

  // Design  configurations
  let accent_line = line(length: 100%, stroke: (paint: hm-black, thickness: 1pt));

  // Fonts
  let body-font = font
  let heading-font = font

  let text-size-template = 10pt
  set text(font: body-font, lang: language, text-size-template)
  set par(justify: true)
  show heading: set text(weight: "semibold", font: heading-font, fill: black)

  set page(
    margin: (
      top: 6em,
      bottom: 6em,
      rest: 6em,
    ),
  )

  // Common Stuff
  let front_end_page = state("front_end_page", 0)

  let current-h1 = state("current-h1", top-remark)

  let hm-header = context {
    set text(text-size-template)

    grid(
      columns: (40%, 20%, 40%),
      align(left)[#doc-type],
      align(center)[
        // #set align(bottom)
        // #set image(height: 25pt)
        // #image("assets/HM_Logo_RGB.png")
      ],
      align(right)[
        #text(style: "italic")[
          #current-h1.get()
        ]
      ],
    )

    accent_line
  }

  // booktab tables
  set table(
    stroke: none,
    inset: (x: 0.6em, y: 0.3em),
  )
  show table.cell.where(y: 0): strong

  let footer(display, end-label, show-accent: true) = context {
    set text(text-size-template)

    if show-accent {
      accent_line
    }

    grid(
      columns: (1fr, 1fr),
      align(left)[
        #if version != none [
          #authors #date.display("[year]")\
          Version #version
        ] else [#authors]
      ],
      align(right)[
        #context {
          let p = counter(page).get()
          let l = counter(page).at(end-label)
          numbering(display, ..p, ..l)
        }
      ],
    )
  }

  // begin contents

  titlepage(
    title: title,
    subtitle: subtitle,
    authors: authors,
    logo: titlepage-logo,
    logo-dimensions: titlepage-logo-dimensions,
    text-size: text-size-template,
    date: date,
  )

  // ------------- Setup Front Matter Lettering --------------

  set page(
    numbering: front-numbering,
    header: hm-header,
    footer: footer(front-numbering, <end_front>),
  )

  counter(page).update(1)

  // contents
  set text(size: text-size)

  // TOC
  if toc-depth != none {
    {
      show heading.where(level: 1): it => {
        v(5em)
        text(size: 20pt, it)
        v(1.25em)
      }
      show outline.entry.where(
        level: 1,
      ): it => {
        v(15pt, weak: true)
        strong(it)
      }

      outline(indent: auto, depth: toc-depth)
    }
  }

  // Heading settings
  show heading.where(level: 1): it => {
    current-h1.update([
      #if it.numbering != none {
        [
          #counter(heading).display(it.numbering)
        ]
      }
      #it.body
    ])

    if chapter-heading-pagebreak {
      pagebreak()
    } else {
      v(2em)
    }
    text(size: 20pt, it)
    v(1.25em)
  }

  show heading.where(level: 2): it => v(1em) + it + v(1em)
  show heading.where(level: 3): it => v(1em) + it + v(0.75em)

  set text(text-size)

  // --------- Space for Glossary Abstract etc ----------
  heading(level: 1)[List of Figures]

  outline(
    title: none,
    target: figure.where(kind: image),
  )

  heading(level: 1)[List of Tables]
  outline(
    title: none,
    target: figure.where(kind: table),
  )

  // Display glossary.
  if glossary != none {
    heading(level: 1, linguify("base_glossary", from: lang-db))
    set par(justify: false)
    set list(spacing: 0.2em)
    set block(spacing: 0.2em)
    print-glossary(
      glossary,
      disable-back-references: true
    )
  }

  if not chapter-heading-pagebreak {
    pagebreak()
  }

  [
    #metadata(none)<end_front>
  ]

  // ---------- Setup Chapter Headings -------------------

  // Do numbered headings
  set heading(numbering: "1.")

  // ------------- Setup Arabic Lettering --------------

  set page(
    numbering: main-numbering,
    header: hm-header,
    footer: footer(main-numbering, <end_body>),
  )

  counter(page).update(1)

  // ----------- Setup Completed - Content ---------------

  body

  // ----------- Other stuff - Bib gloss appendix etc ----

  // Non numbered headings
  set heading(numbering: none)

  // Roman Lettering again
  [#metadata(none)<end_body>]

  show heading.where(level: 1): it => {
    text(size: 20pt, it)
    v(1.25em)
  }

  set page(
    numbering: back-numbering,
    header: hm-header,
    footer: footer(back-numbering, <end_back>),
  )

  // Continue roman count from the last front-matter page:
  context {
    counter(page).update(counter(page).at(<end_front>).first() + 1)
  }

  // Display bibliography.
  if bibliography != none {
    heading(level: 1, linguify("base_references", from: lang-db))
    set std-bibliography(
      title: none,
      style: bib-style
      )
    bibliography
  }

  // reset page numbering for appendix
  set page(
    numbering: appendix-numbering,
    footer: footer(appendix-numbering, <end_back>),
  )
  counter(page).update(1)

  // Display appendix.
  if appendix != none {
    if not chapter-heading-pagebreak {
      pagebreak()
    }

    heading(level: 1, linguify("base_appendix", from: lang-db))
    appendix
  }

  // Last Page, possible for reference, versioning & contact information
  if lastpage != none {
    if not chapter-heading-pagebreak {
      pagebreak()
    }

    lastpage
  }

  [#metadata(none)<end_back>]
}
