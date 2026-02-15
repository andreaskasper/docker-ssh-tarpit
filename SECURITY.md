# Security Policy

## Supported Versions

We release patches for security vulnerabilities for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| latest  | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability within this project, please send an email to Andreas Kasper at andreas.kasper@goo1.de. All security vulnerabilities will be promptly addressed.

Please include the following information:

- Type of issue (e.g., buffer overflow, SQL injection, cross-site scripting, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

## Security Best Practices

When deploying this SSH tarpit:

1. **Move your real SSH server to a non-standard port** (e.g., 2222, 2200)
2. **Use strong authentication** on your real SSH server (key-based, not passwords)
3. **Implement firewall rules** to restrict access to your real SSH port
4. **Monitor the tarpit logs** regularly for suspicious patterns
5. **Set resource limits** to prevent the tarpit from consuming too many resources
6. **Keep the container updated** to the latest version
7. **Run with minimal privileges** (the container already runs as non-root)

## Known Limitations

- This is a honeypot/tarpit, not a complete security solution
- Sophisticated attackers may detect and avoid the tarpit
- Very high volumes of connections could still consume resources
- The tarpit itself could be targeted for DoS attacks (mitigated by resource limits)

## Security Updates

Security updates will be released as soon as possible after a vulnerability is confirmed. We use:

- GitHub Actions for automated security scanning (Trivy)
- Dependabot for dependency updates
- Regular base image updates (Python Alpine)

## Disclosure Policy

When a security vulnerability is reported:

1. We will confirm the problem and determine affected versions
2. We will audit code to find any similar problems
3. We will prepare fixes for all supported versions
4. We will release patches as quickly as possible

Thank you for helping keep this project secure!