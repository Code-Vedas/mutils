build:
	bundle exec rake build
release: build
	git add .
	git commit -am '$(MESSAGE)'
	bundle exec rake release