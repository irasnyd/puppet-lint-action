# GitHub Action for Puppet Lint

This Action for the [Puppet](https://puppet.com/) configuration management
system enables you to syntax check your Puppet code.

This Action for [Puppet Lint](http://puppet-lint.com/) enables arbitrary
actions for interacting with Puppet Lint to test Puppet code against the
recommended [Puppet language style guide](puppet.com/docs/puppet/latest/style_guide.html).

Puppet Lint validates only code style; it does not validate syntax. If you wish
to perform syntax validation, you can use the
[puppet-parser-validate-action](https://github.com/irasnyd/puppet-parser-validate-action/)
Github Action.

## Usage

An example workflow for testing manifests for correct Puppet style - run the
`puppet-lint` command with the path to the files you want to test as `args`.

```yaml
name: Puppet Lint

on: [push]

jobs:
  puppet-lint:

    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: puppet-lint
      uses: irasnyd/puppet-lint-action@master
      with:
        args: ./
```

See [Testing with Puppet Lint](https://github.com/rodjek/puppet-lint#testing-with-puppet-lint)
for full usage details.

## License

The Dockerfile and associated scripts and documentation in this project are
released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
