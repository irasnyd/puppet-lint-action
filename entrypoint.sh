#!/bin/bash -x

set -euo pipefail

exec /usr/bin/puppet-lint "$@"
