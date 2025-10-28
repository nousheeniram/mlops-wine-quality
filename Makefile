.PHONY: setup train serve test docker-build docker-run mlflow fmt lint

setup:
	python -m pip install --upgrade pip
	pip install -e .
	pip install pre-commit ruff black pytest

fmt:
	black .

lint:
	ruff check --fix .

train:
	python -m src.cli_train --config configs/train.yaml

serve:
	uvicorn src.service.app:app --host 0.0.0.0 --port 8000

test:
	pytest -q

docker-build:
	docker build -t mlops-wine-quality:latest .

docker-run:
	docker run -p 8000:8000 mlops-wine-quality:latest

mlflow:
	mlflow ui --backend-store-uri sqlite:///mlruns.db --host 0.0.0.0 --port 5000
