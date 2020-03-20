# whoops

## Interactive debugger for exceptions in CFML

Blatently copied from https://filp.github.io/whoops/ (Thank you!)

### Install

`box install whoops --saveDev`

### Usage

The module will register itself as the `customErrorTemplate` regardless of the environment.  For this reason, make sure you install whoops as a `devDependency`.

Alternatively, you can manually set your `coldbox.customErrorTemplate` to the path to `/whoops/views/whoops.cfm` from your application root.

```
coldbox.customErrorTemplate = "/modules/whoops/views/whoops.cfm";
```

You can open files in your editor directly from the Whoops template by setting a
`WHOOPS_EDITOR` environment variable.  Here are the allowed values:

+ vscode
+ vscode-insiders
+ sublime
+ textmate
+ emacs
+ macvim
+ idea
+ atom
+ espresso

When setting a valid editor, an "Open" button will appear next to the active stacktrace pane.

If you'd like to add an editor, please open a Pull Request adding your editor's url scheme to the top of `views/whoops.cfm`.
