publish:
	jb build .
	ghp-import -n -p -f _build/html/

preview:
	jb build .
	open _build/html/index.html