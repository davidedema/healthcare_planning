FROM aiplanning/planutils:latest

# Install solvers and tools
RUN planutils install -y optic
RUN planutils install -y tfd
RUN planutils install -y ff
RUN planutils install -y downward
RUN planutils install -y scorpion
# Install Java
RUN apt-get update && apt-get install -y default-jre