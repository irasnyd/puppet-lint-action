FROM alpine:3.11

LABEL name="puppet-lint-action"
LABEL repository="https://github.com/irasnyd/puppet-lint-action"
LABEL homepage="https://github.com/irasnyd/puppet-lint-action"

LABEL "com.github.actions.name"="puppet-lint-action"
LABEL "com.github.actions.description"="GitHub Action for puppet-lint"
LABEL "com.github.actions.icon"="share-2"
LABEL "com.github.actions.color"="orange"

LABEL "maintainer"="Ira W. Snyder <https://github.com/irasnyd/>"

RUN apk --no-cache add bash ruby ruby-bundler ruby-json

COPY Gemfile .
RUN bundle install

COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./"]
