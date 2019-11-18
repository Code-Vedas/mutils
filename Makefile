build:
	bundle exec rake build
release: build
	git add .
	git commit -am "Version: Bump"
	bundle exec rake release
