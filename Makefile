test:
	molecule test

publish:
	ansible-galaxy role import chronicc ansible-role-bash -vvv
