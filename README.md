# zanvd.dev

My personal portfolio page.
One page, built with [Zola](https://www.getzola.org/).

## Develop

```bash
make serve   # dev server at http://localhost:8080
make build   # static output in public/
```

Requires Docker. The Zola version is pinned in the `Makefile`.

## Layout

| Path                    | What                                               |
|-------------------------|----------------------------------------------------|
| `data/*.toml`           | Content: experience, stack, projects, open source  |
| `config.toml`           | Domain, description, email and social links        |
| `templates/`            | Page and section partials                          |
| `static/`               | CSS, menu script, fonts, icons, manifest, OG image |
| `DESIGN.md`             | Design brief and decisions                         |
| `reference/`, `assets/` | Original design handoff                            |

## Deploy

Cloudflare Workers (static assets), built from `master`: build command `sh scripts/cf-build.sh`
(downloads Zola, since the build image lacks it), deploy command `npx wrangler deploy`,
build variable `ZOLA_VERSION=0.23.6`.
`wrangler.jsonc` serves `public/`.

## License

Code is MIT, see `LICENSE`.
Content and images are © Žan V. Dragan, all rights reserved.
Fonts are under the SIL Open Font License, see `static/fonts/LICENSE.txt`.
