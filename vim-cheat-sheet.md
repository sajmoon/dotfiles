# Random code navigations

% finds matching pairs of brackets

# Searching

- \* searches forward for the word under the cursor. (exackt match)`
- \# searches backwars for the word under the cursor.

g* and g# would match word in alongwordhere

/term searches for the term
3/term finds the thirds occurance of term

n to search forward
N to search backwards

gnn jump to first match
GN to last

fx forward searches for the char x
Fx backward search for the char x

tx [Till] forward search for x but stops on the preceding char
Tx backwards

; repeats last f, t, F or T

## Paragraphs

vap/ dap - a paragraph

## Jump list

Each search adds file, line and column to the jump list.

You can move back and forth in the jump list:
ctrl-i or tab, jumps to next
ctrl-o, jumps forward.

:jumps to see the jump list

# Tags

`ctag -R .`
(For elixir use alchimist)

ctrl-] jump to method defined under cursor.
(ofc, this adds an entry to the jump list)

# GitGutter

<leader>hs hunk stage
<leader>hu hunk unto
<leader>hp hunk preview

]c next chunk
[c next chunk

# Working with splits

Max out the height of the current split
`ctrl + w _`

Max out the width of the current split
`ctrl + w |`

Swap top/bottom or left/right split
Ctrl+W R

Break out current window into a new tabview
Ctrl+W T

Close every window in the current tabview but the current one
Ctrl+W o
