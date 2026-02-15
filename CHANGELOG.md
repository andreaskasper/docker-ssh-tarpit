# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-02-15

### Added
- Multi-architecture support (amd64, arm64, arm/v7)
- GitHub Actions for automated builds and security scanning
- Healthcheck for container monitoring
- Non-root user execution for enhanced security
- Resource limits in docker-compose examples
- Comprehensive documentation with deployment examples
- Security policy (SECURITY.md)
- Automated testing workflow
- Dependabot configuration
- MIT License
- `.dockerignore` for optimized builds
- Startup banner with configuration display
- MAX_CLIENTS environment variable

### Changed
- **BREAKING**: Default port changed from 2222 to 22
- Switched base image from `python:3` to `python:3.12-alpine` (95% size reduction)
- Implemented multi-stage build for minimal image size
- Updated entrypoint script from bash to sh (Alpine compatibility)
- Modernized docker-compose.yml to version 3.8
- Enhanced README with security best practices and troubleshooting
- Improved logging and monitoring capabilities

### Security
- Container now runs as non-root user (UID 1000)
- Added security labels and OCI metadata
- Enabled read-only root filesystem option
- Dropped all unnecessary capabilities
- Added automated security scanning with Trivy
- Implemented no-new-privileges security option

### Fixed
- Shell compatibility issues (bash → sh)
- Resource consumption limits
- Health check implementation

## [1.0.0] - 2019-XX-XX

### Added
- Initial release
- Basic SSH tarpit functionality
- Docker container support
- Environment variable configuration
- Travis CI integration