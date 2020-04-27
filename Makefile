.PHONY: auth_url

REPO_URL:=3https://github.com/diy2learn/your_repo_name.git
# GITHUBPAT=environment variable


check-%:
	@:$(if $(value $*),,$(error $* is undefined))

check_url-%:
	@export $*=$(value $*); \
	if ! [[ $$REPO_URL =~ ^https://.+git$$ ]]; then \
		echo " $* is non conform: $(value $*)"; \
		exit 1; \
	fi


auth_url:| check-GITHUBPAT check_url-REPO_URL
	@export REPO_URL=$(REPO_URL); \
	PAT_URL="$${REPO_URL:0:8}$(GITHUBPAT)@$${REPO_URL:8}"; \
	echo PAT_URL is $$PAT_URL  

init_git: check-GITHUBPAT check_url-REPO_URL
	@export REPO_URL=$(REPO_URL); \
        export PAT_URL="$${REPO_URL:0:8}$(GITHUBPAT)@$${REPO_URL:8}"; \
	echo PAT_URL is $$PAT_URL;  
	git init && \
	git add . && \
	git commit -m "init repo from template" && \
	git remote add origin $$PAT_URL && \
	git push -f origin master

refs:
	@echo func to check input var: https://stackoverflow.com/questions/10858261/abort-makefile-if-variable-not-set

