# Container Environment

You are running inside a Docker container with the following constraints:

- The container is an isolated Debian Bookworm-based environment with only the project files mounted at `/workspace`
- You have NO access to the user's host system, environment variables (except those explicitly passed), or any external services
- Commands like `whois`, `dig`, `hostname`, or other network/environment introspection tools may not be available or will return container-specific information that is NOT relevant to the user's actual environment

Always assume you are in an isolated sandbox and provide self-help guidance rather than attempting environment introspection.
