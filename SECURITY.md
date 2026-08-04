# Security Policy

EmotionSense AI processes potentially sensitive emotional-reflection data. Security and privacy reports are handled discreetly and with priority.

## Supported Versions

The project has not published a production application release. The foundation tag is supported for repository and documentation security corrections.

| Version | Supported |
| --- | --- |
| Unreleased default branch | Yes |
| `v0.1.0` foundation | Yes |
| Production application releases | None published |

This table will be updated when versioned releases begin. Support commitments for a release must be stated at release time.

## Reporting a Vulnerability

Do not disclose suspected vulnerabilities, exposed credentials, privacy incidents, or sensitive reproduction data in a public issue, discussion, pull request, or fork.

Use GitHub private vulnerability reporting:

1. Open the repository's **Security** tab.
2. Select **Advisories**.
3. Select **Report a vulnerability**.
4. Provide the affected component, impact, reproduction conditions, and suggested mitigation when known.

If private vulnerability reporting is not available, contact the repository owner through a private method listed on their GitHub profile and request a secure reporting channel. Do not include vulnerability details in the initial contact.

Reports should include only the minimum data necessary. Never attach personal recordings, real emotional histories, biometric data, credentials, or production datasets. Use synthetic evidence wherever possible.

## Response Process

Maintainers will aim to:

- Acknowledge a report within three business days.
- Establish severity, scope, and a communication cadence after initial triage.
- Coordinate validation and remediation privately with the reporter.
- Credit the reporter when requested and safe to do so.
- Publish an advisory after affected users can reasonably mitigate the issue.

Timelines depend on severity, reproducibility, downstream coordination, and user risk. Maintainers may request additional evidence but will not ask reporters to collect unnecessary personal data.

## Safe Harbor

Good-faith research is welcomed when it avoids privacy violations, service disruption, data destruction, social engineering, physical intrusion, and access beyond what is necessary to demonstrate a vulnerability. Stop testing and report immediately if you encounter personal or sensitive data.

The project will not pursue action against good-faith research that follows this policy. This statement does not authorize testing of third-party systems or waive obligations imposed by law.

## Scope Notes

Security review should consider mobile permissions, transient media, local storage, exported data, backups, logs, model integrity, dependencies, build provenance, and release signing. Architecture or product changes resulting from a report must follow the project's ADR and review processes.

Repository-owner security settings are tracked in the [GitHub hardening runbook](docs/GITHUB_HARDENING.md).
