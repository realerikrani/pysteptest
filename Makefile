.PHONY: lint
lint:
	python3 -m ruff check .
	python3 -m ruff format . --check
	MYPYPATH=src python3 -m mypy --namespace-packages --explicit-package-bases src

.PHONY: pin
pin:
	python3 -m pip install --only-binary :all: --upgrade pip
	python3 -m pip lock -r requirements/prod.in -r requirements/dev.in -o requirements/pylock.dev.toml

.PHONY: install
install:
	python3 -m pip install --only-binary :all: uv
	python3 -m uv pip sync --preview-features pylock requirements/pylock.dev.toml
	python3 -m pip check

.PHONY: build
build:
	python3 -m pip install --only-binary :all: --upgrade build wheel
	python3 -m build
