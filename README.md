# whoops

## Interactive debug for exceptions in ColdBox

Blatently copied from https://filp.github.io/whoops/ (Thank you!)

### Usage

By default, the module will register itself as the `customErrorTemplate` in the `development` environment.  You can control what environments  are automatically registered using the `targetEnvironments` setting key (either as a list or as an array).

Alternative, you can manually set your `coldbox.customErrorTemplate` to the path to `/whoops/views/whoops.cfm` from your application root.

```
// Usually....

coldbox.customErrorTemplate = "/modules/whoops/views/whoops.cfm";
```