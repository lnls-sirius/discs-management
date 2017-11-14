INSTALL_DIR=/usr/local/bin

install:
	sudo cp -f scripts/* $(INSTALL_DIR)/

develop:
	sudo ln -fs $(PWD)/scripts/* $(INSTALL_DIR)/
