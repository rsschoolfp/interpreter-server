setup:
	stack setup
	stack build

dev-setup: setup
	stack install ghcid

dev:
	@ghcid -T 'Main.main'
