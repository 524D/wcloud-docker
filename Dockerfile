# syntax=docker/dockerfile:1

FROM ubuntu:24.04 AS final

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/   #user
# ARG UID=10001
# RUN adduser \
#     --disabled-password \
#     --gecos "" \
#     --home "/nonexistent" \
#     --shell "/sbin/nologin" \
#     --no-create-home \
#     --uid "${UID}" \
#     appuser
# USER appuser

# Copy the executable from the "build" stage.
COPY wcloud /wcloud

# What the container should run when it is started.
CMD ["/wcloud", "--help"]
