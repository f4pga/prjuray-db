
DATABASE_FILES = *.csv *.db *.json *.yaml
TIMINGS_FILES = *.sdf

DATABASE_PARTS = zynqusp kintexus

define clean-db =
clean-$(1)-db:
	rm -f $$(addprefix $(1)/,$$(DATABASE_FILES))
	rm -f $$(addprefix $(1)/timings/,$$(TIMINGS_FILES))

clean-db: clean-$(1)-db
	@true
endef
$(foreach part,$(DATABASE_PARTS),$(eval $(call clean-db,$(part))))

clean: clean-db
	@true

.PHONY: $(foreach part,$(DATABASE_PARTS),clean-$(part)-db) clean-db clean

reset:
	git reset --hard

.PHONY: reset

update:
	git stash
	git fetch origin
	git merge origin/master
	git stash pop

.PHONY: update
