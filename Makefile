
NAME = tfe
VERSION = 0.1.0

DESTDIR = 
BINDIR = /usr/local/bin/

.PHONY: install
install:
	@echo -e "Installing $(NAME)"
	@echo -e "  Copying scripts..."
	@install -Dm755 $(NAME).sh $(DESTDIR)$(BINDIR)$(NAME)

.PHONY: uninstall
uninstall:
	@echo -e "Uninstalling $(NAME)"
	@echo -e "  Removing scripts..."
	@rm $(DESTDIR)$(BINDIR)$(NAME)

.PHONY: dist
dist:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(VERSION) | gzip -9 > $(NAME)-$(VERSION).tar.gz
	@md5sum $(NAME)-$(VERSION).tar.gz

clean:
	@echo -e "Cleaning current directory"
	@echo -e "  Erasing all *.tar.gz files..."
	@rm *.tar.gz

