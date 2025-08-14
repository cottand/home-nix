# PRs
- Run `gofmt -w ./$the_folder/*` on Go folders changed before opening a PR
- Keep descriptions brief, no need to list all commits
- Include in descriptions only changes 'before/after' the PR, as if the PR is a squashed commit. No need
to describe iterations made within PR development
- Always open PRs as drafts

# Code comments
- Use comments sparingly, never write comments for trivial self-explanatory code
- Don't comment out code, remove it instead
- Don't add comments that describe the process of changing code
    - Comments should not include past tense verbs like added, removed, or changed
    - Example: `this.timeout(10_000); // Increase timeout for API calls`
    - This is bad because a reader doesn't know what the timeout was increased from, and doesn't care about the old behavior
- Don't add comments that emphasize different versions of the code, like "this code now handles"
- If you do comment, do not use end-of-line comments
    - Place comments above the code they describe
- Never create documentation files (`*.md` or README).
    - Only create documentation files if explicitly requested by the user.
