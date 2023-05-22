creds:
	bash set_az_cred.sh

profile:
	bash set_az_profile.sh

tag:
ifdef v
	bash script/tag.sh $(v)
else
	$(error TAG_VERSION is undefined)
endif