tell application "Finder"
	set p to "/Users/cscharf/Dropbox/work/"
	reveal (POSIX file p as text)
	activate
end tell
