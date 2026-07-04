# Container Environment

You are running inside a Docker container with the following constraints:

- The container is an isolated Debian Bookworm-based environment with only the project files mounted at `/workspace`
- You have NO access to the user's host system, environment variables (except those explicitly passed), or any external services
- Commands like `whois`, `dig`, `hostname`, or other network/environment introspection tools may not be available or will return container-specific information that is NOT relevant to the user's actual environment

## How to Help with Environment-Related Questions

When the user asks about their environment, network configuration, DNS, installed tools, or similar system-level questions:

1. **DO NOT** try to run commands to check the user's environment from inside the container
2. **DO NOT** assume the container environment reflects the user's actual setup
3. **INSTEAD** provide step-by-step guides and advice on how the user can check their own environment

For example:
- If asked about DNS issues, explain how the user can run `nslookup`, `dig`, or check their DNS settings on their host machine
- If asked about installed tools, guide the user to run `which <tool>`, `<tool> --version`, or check their package manager on their host
- If asked about network connectivity, provide commands the user can run on their host system

Always assume you are in an isolated sandbox and provide self-help guidance rather than attempting environment introspection.
