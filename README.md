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

If you wish to use a specific version, without needing to rebuild the container
each time, you can use the version hosted on the [Docker Hub](https://hub.docker.com/r/irasnyd/puppet-parser-validate-action).

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
      uses: docker://irasnyd/puppet-lint-action:2.4.2-1
      with:
        args: ./
```

For example:

See [Testing with Puppet Lint](https://github.com/rodjek/puppet-lint#testing-with-puppet-lint)
for full usage details.

## Full Example

```yaml
name: Puppet Lint

on: [push]

jobs:
  puppet-lint:

    runs-on: ubuntu-18.04

    steps:

    # Checkout the source code from the Github repository
    - name: Checkout Source Code
      uses: actions/checkout@v2
      with:
        fetch-depth: 0

    # Determine which files changed in the commit(s) in this Pull Request
    # https://github.com/trilom/file-changes-action
    # https://github.com/marketplace/actions/file-changes-action
    - name: Get Changed Files
      id: get_file_changes
      uses: trilom/file-changes-action@v1.2.3

    # Filter out Puppet manifests (*.pp) from the added/modified files
    # Store the Puppet manifest filenames into output named: files
    # Store the number of Puppet manifests into output named: numfiles
    - name: Filter Puppet Manifests
      id: puppet_manifests
      run: |
        jq '.[] | select(.|endswith(".pp"))' $HOME/files_added.json $HOME/files_modified.json > $HOME/manifests.txt
        echo "::set-output name=files::$(cat $HOME/manifests.txt | tr '\n' ' ')"
        echo "::set-output name=numfiles::$(cat $HOME/manifests.txt | wc -l)"

    # Puppet Lint on added/modified Puppet manifests
    - name: Puppet Lint
      uses: docker://irasnyd/puppet-lint-action:2.4.2-1
      with:
        args: --no-140chars-check --no-class_inherits_from_params_class-check --no-relative_classname_inclusion-check ${{ steps.puppet_manifests.outputs.files }}
      if: "steps.puppet_manifests.outputs.numfiles > 0"
```

## License

The Dockerfile and associated scripts and documentation in this project are
released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See
[THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
