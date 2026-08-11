# ADR-0012: User-Authored Reflection Records

- Date: 2026-08-09
- Owners: Product Architecture, Privacy, Security, and Mobile Engineering leads
- Decision scope: Reconcile reflection/history requirements with the local-only inference-data policy
- Related: OD-15, TD-15, ADR-0009, ADR-0010

## Status

Accepted

## Context

The original product requirements described accepting, changing, and retaining machine-generated interpretations in local history. ADR-0009 and the Data Handling Policy prohibit persistence of scores, labels, timelines, session summaries, histories, and other camera-derived or inference-derived data. Those statements cannot both govern implementation.

## Decision

The initial product may persist **only deliberately user-authored reflection records**. A record may contain user-entered text, user-selected tags, and a user-selected reflection date/time. The application must make clear that these are the user's notes, not measurements or inferred history.

Reflection records must not contain, reference, derive from, or be automatically populated with camera frames, face geometry, tensors, scores, labels, confidence, quality signals, session identifiers, capture timestamps, model versions, or machine-generated interpretations. A live estimate may be dismissed or used as private context while composing a note, but it is discarded when the session ends and is never written with the note.

User-authored records are local-only, user-controlled, excluded from analytics, logs, crash reports, exports by default, and backups where platform controls permit. Persistence implementation requires a separate storage-protection decision covering encryption/key management, backup behavior, deletion, migration, and export before a repository or database is introduced.

## Consequences

- The PRD's machine-interpretation acceptance and inferred-history requirements are replaced with user-authored reflection behavior.
- Chronological history and user-requested summaries may describe only user-authored records; they must not imply an observed expression trend or a clinical pattern.
- No inference persistence, profile, or longitudinal model output is authorized by this decision.
- A later proposal to join a reflection to an estimate, save a label, create an automatic timeline, or export records requires a new ADR and privacy/security review.

## Validation

- Documentation must use the terms “user-authored reflection” and “machine-derived data” consistently.
- Automated persistence tests, once storage exists, must prove that prohibited machine-derived fields cannot be written or restored.
- The mandatory ADR-0010 privacy regression checklist applies to every release.

## Evidence Classification

- **Facts:** ADR-0009 and the Data Handling Policy prohibit inference-derived persistence.
- **Trade-offs:** Removing automatic result history sacrifices convenience to avoid creating a sensitive expression profile.
- **Constraints:** This decision does not authorize a database, export, telemetry, or model-result retention.
