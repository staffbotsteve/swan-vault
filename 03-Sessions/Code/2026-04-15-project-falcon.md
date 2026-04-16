---
date: 2026-04-15
source: Claude Code
project: Project Falcon
duration: ~10 minutes
status: Completed
---

## Task
Create the student service layer (`src/services/students.ts`) with Supabase-first queries and automatic mock data fallback.

## Outcome
The service exports `getStudents` and `getStudentById`, both of which attempt Supabase first and fall back to mock data on any error. This ensures the app functions correctly regardless of whether the database tables exist. Build passed with zero TypeScript errors and the file was committed to git.

## Decisions Made
- `USE_MOCK` constant was dropped in favor of always trying Supabase first with try/catch fallback — cleaner and handles the real-world state where the URL is set but tables don't exist yet
- `gradeLevel` and `gpa` are derived from the enrollment matching `academicYear` filter (defaulting to `CURRENT_YEAR = '2025-2026'`)
- Relationship resolution skips orphaned records (other person not found in mockPersons) rather than throwing
- Supabase `getStudentById` returns a stub with empty arrays for dependent tables that don't exist yet
- Re-exported `StudentRow` intersection type so consumers don't have to re-declare it

## Files Changed
- `src/services/students.ts` — created (214 lines)

## Blocked / Needs Input
None. Build is green.

## Next Steps
- Task 5: Build reusable UI components (Avatar, Tabs, FilterBar)
- Task 6: StudentTable component consuming this service
