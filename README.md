# pi-agent Docker Setup

A containerized setup for running [pi](https://www.npmjs.com/package/@mariozechner/pi-coding-agent), an AI-powered coding agent, pre-configured to route requests through ollama.

The container mounts your local code into `/workspace`, giving the agent full access to read, edit, and execute code in your project — all from within an isolated environment.

If you have docker already installed it is just build and run :runner:.

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running

---

## Usage

### 1. Build the image

```bash
# Using make (recommended)
make

# Or directly with docker
docker build -t pi-agent .
```

This builds a Docker image with `pi` installed and the LiteLLM provider extension pre-configured.

### 2. Run the agent

The easiest way is via `make`, which also builds the image if needed:

```bash
# Using ai-login to obtain the API key dynamically (recommended)
make run

# Using a local .env file
make run-env
```

Or manually with Docker:

```bash
docker run -it \
  --cap-drop ALL \
  --security-opt no-new-privileges \
  -v "$(pwd):/workspace" \
  pi-agent
```

- `--cap-drop ALL` / `--security-opt no-new-privileges` — drop all Linux capabilities and prevent privilege escalation inside the container
- `-v "$(pwd):/workspace"` — mounts your current directory into the container so the agent can access your project files
- `-it` — runs the container in interactive mode so you can chat with the agent

And you can create an alias so you can run it with two keystrokes (make sure you've run `make build` first):

```bash
alias pi='docker run -it --cap-drop ALL --security-opt no-new-privileges -v "$(pwd):/workspace" pi-agent'
```

Easy as `pi`.

---

## Why this image?

**Pi by default runs in YOLO mode**, it will not ask for permissions, it will just go and do what it needs to do, so installing it globally in your computer is **very riskly and highly unrecommended**.

When you run it in this way pi can not see all your environment variables, only the ones you pass in the .env or the docker run command. It only has access to the files mounted in the docker volume.

To the agent is like it is in an empty Debian Bookworm container with a folder of the project and one key to send the requests. So the risk of it doing destructive actions it is greatly reduced.

## Contributing

The `main` branch will keep a simple image faithful to [the spirit of pi](https://mariozechner.at/posts/2025-11-30-pi-coding-agent/). Do you want plan mode or sub-agents? add [an extension](https://github.com/badlogic/pi-mono/tree/main/packages/coding-agent/examples/extensions) or ask pi to build it for you!.

If you want to share your customizations, create a branch with your user name or whatever name you want to give it and describe it below:

## Building local models

  Sample config for running ollama models, includes a sample Modelfile for `qwen 3.5 9b`, (you can use `qwen 3.5 27b` depending on your machine) how to create the model image:

  ```shell
  ollama pull qwen3.5:9b
  ollama create qwen-coding -f Modelfile
  ```

  Then run it with (the only difference with master is --network=host ):

  ```shell
  make run
  ```
