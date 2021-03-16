install:
	swift build -c release
	install .build/release/appletime /usr/local/bin/appletime