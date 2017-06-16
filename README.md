# whoops
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors)

## Interactive debug for exceptions in CFML

Blatently copied from https://filp.github.io/whoops/ (Thank you!)

### Install

`box install whoops --saveDev`

### Usage

The module will register itself as the `customErrorTemplate` regardless of the environment.  For this reason, make sure you install whoops as a `devDependency`.

Alternatively, you can manually set your `coldbox.customErrorTemplate` to the path to `/whoops/views/whoops.cfm` from your application root.

```
coldbox.customErrorTemplate = "/modules/whoops/views/whoops.cfm";
```
## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
| [<img src="https://avatars2.githubusercontent.com/u/2583646?v=3" width="100px;"/><br /><sub>Eric Peterson</sub>](https://github.com/elpete)<br />[💬](#question-elpete "Answering Questions") [💻](https://github.com/elpete/whoops/commits?author=elpete "Code") [📖](https://github.com/elpete/whoops/commits?author=elpete "Documentation") | [<img src="https://avatars3.githubusercontent.com/u/11138835?v=3" width="100px;"/><br /><sub>Angel Chrystian</sub>](https://github.com/angel-chrystian)<br />[🐛](https://github.com/elpete/whoops/issues?q=author%3Aangel-chrystian "Bug reports") [💻](https://github.com/elpete/whoops/commits?author=angel-chrystian "Code") |
| :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!