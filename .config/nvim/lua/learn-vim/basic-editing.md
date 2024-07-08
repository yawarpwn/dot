## Vim Command Mental Model

This mental model helps you efficiently perform various text editing tasks by combining simple commands.

**Navigation Commands (Motions):**

- Move the cursor (e.g., `h`, `j`, `k`, `l`, `w`, `b`, `f`).
- Can be prefixed with a count: `<count><motion>`.

**Verbs:**

- Combine with motions to perform actions: `<verb><count><motion>`.
- Common verbs: `d` (delete), `c` (change), `y` (yank), `v` (visual).

**Deleting Text:**

- Using `d` with Motions:

  - `dh`: Delete character to the left.
  - `d3w`: Delete three words.
  - `d^`: Delete to the beginning of the line.
  - `d$` or `D`: Delete to the end of the line.
  - `dd`: Delete the entire line.

- Combining with Counts:
  - `3dd`: Delete three lines.
  - `d2fe`: Delete to the second `e` after the cursor.

**Changing Text:**

- Using `c` with Motions:
  - `c<motion>`: Delete and enter insert mode.
  - `cc`: Change the entire line.

**Shortcut Commands:**

- For Single Characters:

  - `x`: Delete the character under the cursor.
  - `r<char>`: Replace the character under the cursor.

- Joining Lines:
  - `J`: Join the current line with the next one.
  - `gJ`: Join lines without modifying whitespace.

**Manipulating Case:**

- Convert Case:
  - `gU<motion>`: Convert to uppercase.
  - `gu<motion>`: Convert to lowercase.
  - `~`: Invert the case of the character under the cursor.

**Repeating and Recording Commands:**

- Repeating Commands:

  - `.`: Repeat the last command.
  - Can be combined with counts for nuanced repetitions.

- Recording Commands:
  - `qq`: Start recording.
  - `q`: Stop recording.
  - `qQ`: Append to a recording.
  - `Q`: Play back the most recent recording.
