# Supercharged-HM Changelog

## [v1.0.0] - 2026-06-13

- Breaking: removed `show-table-of-contents`; use `toc-depth: none`.
- Breaking: renamed requirement metadata `tracebility` to `traceability`.
- Breaking: renamed `req_funcional` to `req_functional`.
- Breaking: removed `titlepage-logo-dimensions` and `project-logo-dimensions`; pass sized logo content instead.
- Add thesis title page, thesis metadata, declaration of authorship, abstract, and acknowledgements support.
- Add configurable page numbering and lists of tables, figures, and code snippets.
- Add `toc-pagebreak`, `chapter-heading-pagebreak`, and header `project-logo` support.
- Track the current heading in page headers.
- Update README and examples for v1.0.0.
- Fix German list-of-figures localization, requirement author rendering, package naming, and stale imports.

## [v0.1.2] - 2026-01-18

- fix incorrectly scoped show rule for glossarium glossary rendering
- fix incorrect date propagation to titlepage [PR#2](https://github.com/FelixSchladt/supercharged-hm/pull/2) 

## [v0.1.1] - 2026-01-07

- Bugfix: Though the appendix is expected as content, the template imported it as file.
- Change: Renamed source repository to align with packet name 

## [v0.1.0] - 2025-11-26

- Initial release
