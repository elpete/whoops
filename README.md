# whoops

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