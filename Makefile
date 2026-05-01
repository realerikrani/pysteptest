.PHONY: lint
lint:
	python3 -m ruff check .
	python3 -m ruff format . --check
	MYPYPATH=src python3 -m mypy --namespace-packages --explicit-package-bases src

.PHONY: pin
pin:
	python3 -m pip install --only-binary :all: --upgrade 'pip == 26.1'
	python3 -m pip lock --uploaded-prior-to=P2D -r requirements/prod.in -r requirements/dev.in -o requirements/pylock.dev.toml

.PHONY: install
install:
	python3 -m pip install --uploaded-prior-to=P2D --only-binary :all: --no-deps -r requirements/pylock.dev.toml
	python3 -m pip check

.PHONY: build
build:
	python3 -m pip install --uploaded-prior-to=P2D --only-binary :all: --upgrade build wheel
	python3 -m build
