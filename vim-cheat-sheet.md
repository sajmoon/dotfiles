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


