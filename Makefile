changelog:
	github_changelog_generator --user niteshpurohit --project mutils
build:
	bundle exec rake build
release: build
	git add .
	git commit -am '$(MESSAGE)'
	bundle exec rake release