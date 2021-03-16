# GODOT PIECES: Top Down Grid Navigation
A few (four) simple, grid-based movement scripts (for Godot) using a top-down
viewpoint.

## Controls

| BUTTON | FUNCTION |
| --- | --- |
| W / D-Pad UP / Thumbstick UP | North |
| S / D-Pad DOWN / Thumbstick DOWN | South |
| A / D-Pad LEFT / Thumbstick LEFT | West |
| D / D-Pad RIGHT / Thumbstick RIGHT | East |

## Descriptions

### "Closing Chimera" | ./ff/
This is a setup similar to old-school Final Fantasy. Your character will
continue traversing tiles until you release the input button. There's also a
nice walking animation.
### "Random Rouge" | ./rogue/
This works like even older-school Rogue games. A single button press will move
the character one tile. You cannot hold the input button down (ideal for
turn-based games).
### "Random Rouge but Fancy" | ./rogue_tween/
A happy medium between "Closing Chimera" and "Random Rouge". A single button
press moves the character one tile, and it includes a nice animation.
### "Properly Panzer" | ./tank/
Because tank controls are objectively the best type of control. West/East
controls turn the character, and North/South controls move them forward or
backward.

## How to use in your game

If this thing will help you, use it in your game. It has an MIT License, you
can use it for whatever you like. Here's how to use it:

1. Pick whichever one you want to use
2. Add the folder to your project
3. To get controls to work, you will either need to:
- Go into `Project > Project Settings.. > Input Map` and add
	player_up
	player_right
	player_down
	player_left
- Go into the script and change references of `player_left`, `player_down`, etc.
  to `ui_left`, `ui_down`, etc.
4. The character sheets are CC0 (care of [0x72's 2 Bit Character
   Generator](https://0x72.itch.io/2bitcharactergenerator)) so feel free to use
   them or swap them with your own.
5. My code cleverly uses the animation names, so if you need to change the
   animations you'll need to make sure to keep the names. Here's a list:
- facing_up
- facing_down
- facing_left
- facing_right
- step_up
- step_down
- step_left
- step_right

## The World scene
This is just a test scene to check out the different types of controls. There
are only two unique controls:

| BUTTON | FUNCTION |
| --- | --- |
| Q / Triangle / Y | Switch Types |
| ESC / Circle / B | Quit Scene |

## Notes about these scripts
1. Using `get_action_strength` __and__ `is_action_pressed` is overkill -- I know
   this now. I might update this at some point, but I have also learned a few
   good use cases for either:
- get_action_strength - this is probably best used if you care about how much
  the button is being pressed (e.g. slightly tilting the thumbstick causes the
  player to walk, full tilt causes a sprint), or if you prefer a more
  compact/clever control implementation, then get_action_strength is best
- is_action_pressed - this is just a clearer implementation. Also, if you don't
  need to worry about input amounts then use this.
2. I use the same constant (SPEED) for both the animation speed and the tween
   duration. This is because they work together. I can do this because
   speed_scale will decrease the tween duration in proportion. For example: a 1
   second animation at a 4x speed_scale will run for 1/4 of a second, so we want
   the tween to end after 1/4 of a second.
3. The TILE_SIZE constant is declared in the player control script, but you
   should probably put that somewhere else (like in a global script) so all
   entities abide by the same grid. To implement, you can do something like
   `onready var TILE_SIZE = get_node('/root/globals/').TILE_SIZE`
4. I prefer to use custom input mappings (`player_right`, `player_down`, etc.)
   because then I can make them descriptive of what I'm doing, and because I
   want them clearly separate from Godot's built-ins for fear of triggering some
   weird bug.
5. I think I learned the most from implementing the tank controls. I'll have to
   remember that next time.
6. Turns out I like my code to be cute :-)
