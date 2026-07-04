# Use a lightweight Node.js image
# Pin by multi-arch manifest digest for reproducible builds.
# To update: check https://hub.docker.com/_/node/tags?name=24-bookworm-slim for the new digest.
ARG NODE_IMAGE=node:24-bookworm-slim@sha256:879b21aec4a1ad820c27ccd565e7c7ed955f24b92e6694556154f251e4bdb240
FROM ${NODE_IMAGE}

# Install git and pi-coding-agent globally
RUN apt-get update && apt-get install -y --no-install-recommends git ripgrep fd-find && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd

# Pull the package metadata. If it changes, cache is busted from here down and the package is reinstalled with the new version.
ADD "https://registry.npmjs.org/@mariozechner/pi-coding-agent" /tmp/package-info.json
RUN npm install -g @mariozechner/pi-coding-agent

# Create the required directory structure for pi extensions under the node user's home
# and ensure the node user (UID 1000, matching host user) owns everything
RUN mkdir -p /home/node/.pi/agent/extensions && chown -R node:node /home/node/.pi
RUN mkdir -p /workspace/node_modules && chown node:node /workspace/node_modules

# Copy the extension file into the container
COPY --chown=node:node extensions/ /home/node/.pi/agent/extensions/

# Copy the settings file into the container
COPY --chown=node:node .pi/settings.json /home/node/.pi/agent/settings.json

# Copy the models file into the container (for custom providers like Ollama)
COPY --chown=node:node .pi/agent/models.json /home/node/.pi/agent/models.json

# Switch to the non-root node user (UID 1000) so all files created at runtime
# are owned by UID 1000, which matches the host user
USER node

# Set the working directory (this is where we will mount your code)
WORKDIR /workspace

# Start the agent when the container runs
ENTRYPOINT ["pi"]
