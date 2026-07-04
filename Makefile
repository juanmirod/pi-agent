.PHONY: build run run-env

build:
	docker build -t pi-agent . --no-cache

# Run using ai-login to obtain the API key dynamically (recommended)
run: build
	docker run -it \
	  --cap-drop ALL \
	  --security-opt no-new-privileges \
	  --network=host \
	  -v "$$(pwd):/workspace" \
	  pi-agent
