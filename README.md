GRID SYSTEM

The grid system is the foundation of the game’s spatial organization and enemy management. It divides the entire world into smaller, fixed-size regions called chunks. Each chunk represents a specific area of the world and stores references to enemies currently located inside it. This structure makes it much faster to find, update, and draw only the enemies near the player instead of scanning every enemy in the world.

The grid is defined by three constants that set its size and resolution.

constant CHUNK_SIZE   = 4
constant WORLD_WIDTH  = 2048
constant WORLD_HEIGHT = 2048

Each chunk is 4 units wide and tall, and the world spans 2048 units in both dimensions.
From these values, the total number of grid cells is calculated.

integer grid_cols, grid_rows
grid_cols = floor(WORLD_WIDTH / CHUNK_SIZE)
grid_rows = floor(WORLD_HEIGHT / CHUNK_SIZE)

This creates a grid layout with 512 columns and 512 rows, providing a fine-grained structure for organizing entities across the entire world space.

To manage data efficiently, the grid uses two parallel two-dimensional arrays: empty and empty_freelist.
The empty array stores the list of enemies (by index) currently present in each chunk. Each entry corresponds to one chunk in the world and contains a sequence of enemy indices.
The empty_freelist array stores the list of available or reusable slots within each chunk. When an enemy is deleted, its slot is returned to this freelist, so it can be reused later instead of continuously expanding memory. This prevents the chunk lists from growing indefinitely over time and keeps memory usage stable.

Each chunk keeps:
A list of indices pointing into the main enemy list, so the grid never stores full enemy data, just lightweight references.
A list of free chunk slots, which prevents the grid arrays from growing endlessly as enemies spawn and die.

sequence empty, empty_freelist
empty = {}
empty_freelist = {}

for r = 1 to grid_rows do
    empty = append(empty, repeat({}, grid_cols))
    empty_freelist = append(empty_freelist, repeat({}, grid_cols))
end for

When the game world or a level is reset, the grid is cleared using the grid_init() procedure, which resets both arrays and prepares the grid to be reused.

global procedure grid_init()
    empty = {}
    empty_freelist = {}

    for r = 1 to grid_rows do
        empty = append(empty, repeat({}, grid_cols))
        empty_freelist = append(empty_freelist, repeat({}, grid_cols))
    end for
end procedure

The grid can find which chunk a position belongs to using get_chunk(x, y).
This function converts world coordinates into grid coordinates by dividing by CHUNK_SIZE, flooring the result, and clamping values so they never fall outside valid boundaries.
This ensures that every coordinate in the world always maps to a valid chunk cell.

global function get_chunk(atom x, atom y)
    integer cx, cy

    cx = floor(x / CHUNK_SIZE)
    cy = floor(y / CHUNK_SIZE)

    if cx < 1 then cx = 1 end if
    if cy < 1 then cy = 1 end if
    if cx > grid_cols then cx = grid_cols end if
    if cy > grid_rows then cy = grid_rows end if

    return {cx, cy}
end function

The grid also maintains two global lists:
class_list – the master list of active grid entries that hold an enemy’s position, handle, and chunk references.
class_freelist – a list of reusable handles for deleted or inactive grid entries.

sequence class_list, class_freelist
class_list = {}
class_freelist = {}

Each grid entry inside class_list stores multiple properties like world position, enemy handle, chunk coordinates, and handle references used for efficient updating and deletion.

constant grid_x = 1
constant grid_y = 2
constant grid_enemy_handle = 3
constant grid_list = 4
constant grid_emptylist = 5
constant grid_cx = 6
constant grid_cy = 7
constant grid_empty_handle = 8

When an enemy is deleted, the empty_delete() procedure removes its reference from the chunk, frees its slot, and places the handle back into the freelist so it can be reused later.
This prevents the lists from continuously expanding and keeps both the chunk arrays and the main class list compact.

global procedure empty_delete(integer handle)
    integer cx, cy, empty_handle, enemy_id

    if handle < 1 or handle > length(class_list) then
        puts(1, "empty_delete: invalid handle\n")
        return
    end if

    if length(class_list[handle]) = 0 then
        puts(1, "empty_delete: invalid handle\n")
        return
    end if

    enemy_id = class_list[handle][grid_enemy_handle]
    grid_remove_enemy(enemy_id)

    cx = class_list[handle][grid_cx]
    cy = class_list[handle][grid_cy]
    empty_handle = class_list[handle][grid_empty_handle]

    if cy >= 1 and cy <= grid_rows and cx >= 1 and cx <= grid_cols then
        if empty_handle > 0 and empty_handle <= length(empty[cy][cx]) then
            empty[cy][cx][empty_handle] = {}
            empty_freelist[cy][cx] = append(empty_freelist[cy][cx], empty_handle)
        end if
    end if

    class_list[handle] = {}
    class_freelist = append(class_freelist, handle)
end procedure

When new enemies spawn, grid_new() creates a grid entry, calculates its chunk location, and inserts it into that chunk’s list of active entities.
If the chunk’s freelist contains available slots, it uses one instead of allocating a new entry.
This ensures that each chunk only grows as needed and reuses its available space as enemies are created and destroyed.

global function grid_new(atom x, atom y, integer enemy)
    integer handle, cx, cy, empty_handle
    sequence chunk

    if length(class_freelist) > 0 then
        handle = class_freelist[1]
        class_freelist = class_freelist[2..length(class_freelist)]
    else
        class_list = append(class_list, {})
        handle = length(class_list)
    end if

    class_list[handle] = {x, y, enemy, {}, {}, 0, 0, 0}

    chunk = get_chunk(x, y)
    cx = chunk[1]
    cy = chunk[2]

    class_list[handle][grid_cx] = cx
    class_list[handle][grid_cy] = cy

    if length(empty_freelist[cy][cx]) > 0 then
        empty_handle = empty_freelist[cy][cx][1]
        empty_freelist[cy][cx] = empty_freelist[cy][cx][2..length(empty_freelist[cy][cx])]
    else
        empty[cy][cx] = append(empty[cy][cx], {})
        empty_handle = length(empty[cy][cx])
    end if

    class_list[handle][grid_empty_handle] = empty_handle
    empty[cy][cx][empty_handle] = {enemy}

    return handle
end function

As enemies move across the world, grid_update_position() checks if they have entered a different chunk.
If so, the system removes them from the old chunk’s list and inserts them into the new one, updating their stored grid coordinates.
This keeps all positional data accurate without unnecessary duplication or scanning.

global procedure grid_update_position(integer handle, atom new_x, atom new_y)
    integer old_cx, old_cy, new_cx, new_cy, old_empty_handle, new_empty_handle
    sequence new_chunk

    if handle < 1 or handle > length(class_list) then return end if
    if length(class_list[handle]) = 0 then return end if

    old_cx = class_list[handle][grid_cx]
    old_cy = class_list[handle][grid_cy]
    old_empty_handle = class_list[handle][grid_empty_handle]

    new_chunk = get_chunk(new_x, new_y)
    new_cx = new_chunk[1]
    new_cy = new_chunk[2]

    class_list[handle][grid_x] = new_x
    class_list[handle][grid_y] = new_y

    if new_cx != old_cx or new_cy != old_cy then

        if old_cx >= 1 and old_cx <= grid_cols and old_cy >= 1 and old_cy <= grid_rows then
            if old_empty_handle > 0 and old_empty_handle <= length(empty[old_cy][old_cx]) then
                empty[old_cy][old_cx][old_empty_handle] = {}
                empty_freelist[old_cy][old_cx] = append(empty_freelist[old_cy][old_cx], old_empty_handle)
            end if
        end if

        if length(empty_freelist[new_cy][new_cx]) > 0 then
            new_empty_handle = empty_freelist[new_cy][new_cx][1]
            empty_freelist[new_cy][new_cx] = empty_freelist[new_cy][new_cx][2..length(empty_freelist[new_cy][new_cx])]
        else
            empty[new_cy][new_cx] = append(empty[new_cy][new_cx], {})
            new_empty_handle = length(empty[new_cy][new_cx])
        end if

        empty[new_cy][new_cx][new_empty_handle] = {class_list[handle][grid_enemy_handle]}

        class_list[handle][grid_cx] = new_cx
        class_list[handle][grid_cy] = new_cy
        class_list[handle][grid_empty_handle] = new_empty_handle
    end if
end procedure

Finally, grid_get_nearby(x, y, range) allows the game to quickly retrieve all enemies within a given area.
It uses the grid structure to check only the chunks surrounding the player rather than iterating through every enemy.
This selective search makes proximity checks extremely efficient, especially in large worlds with hundreds of enemies.

global function grid_get_nearby(atom x, atom y, integer range)
    sequence results, chunk
    integer cx, cy, min_cx, max_cx, min_cy, max_cy

    chunk = get_chunk(x, y)
    cx = chunk[1]
    cy = chunk[2]
    results = {}

    min_cx = max(1, cx - range)
    max_cx = min(grid_cols, cx + range)
    min_cy = max(1, cy - range)
    max_cy = min(grid_rows, cy + range)

    for yy = min_cy to max_cy do
        for xx = min_cx to max_cx do
            for i = 1 to length(empty[yy][xx]) do
                if sequence(empty[yy][xx][i]) and length(empty[yy][xx][i]) > 0 then
                    results = append(results, empty[yy][xx][i])
                end if
            end for
        end for
    end for

    return results
end function

In summary, the grid system divides the world into chunks, each chunk storing a list of enemy indices and a freelist of reusable slots.
This design ensures that as enemies spawn, move, and die, the grid remains synchronized, compact, and efficient.
It prevents chunk lists from expanding endlessly and allows other systems—like enemy AI, spawning, and rendering—to quickly access only the nearby enemies they need.
The result is a scalable world management structure capable of handling thousands of active entities with minimal performance overhead.


Enemy Spawner

The enemy spawner controls how and where enemies appear in the world. Instead of blindly creating enemies everywhere, it uses the grid and the player’s location to spawn intelligently.

It defines two circular boundaries around the player. The inner circle prevents enemies from spawning too close. The outer circle defines the maximum spawn distance.

Enemies are generated randomly in the space between these circles. Before spawning, the system checks the grid to ensure the area isn’t already crowded and that it’s a valid terrain type not inside walls or mountains.

By using the grid, the spawner avoids overpopulating distant regions and keeps performance stable. It can also vary spawn rates and enemy types depending on the player’s distance from the map centre, placing weaker enemies near the edges and stronger ones deeper inside.

Draw and Update System

The draw and update system handles the visual and logical updates of all entities each frame. To optimize performance, it doesn’t process every enemy, only those within range of the player.

Each frame, it calls the grid’s nearby function to get a list of enemies within a set distance. This list of handles is used to update AI logic, animation, movement, and rendering only for those enemies. This approach drastically reduces CPU load in large worlds.

The system then updates the player’s position, animations, and interactions. Finally, it draws everything, first the world or background, then nearby enemies, and finally the player and UI elements, ensuring correct rendering order.

This design keeps the gameplay smooth even when hundreds of enemies exist in the world since only a small subset near the player is ever active or visible at once.


Projectiles and Weapons:

Implement piercing bullets for equipment: Allow projectiles to pass through enemies and hit multiple targets without deleting the projectile on the first hit (instead of destroying it like on exit button collision).
Add a "MultiHit" feature for piercing projectiles.
Add an arrow indicator that points to the nearest enemy relative to the player.


Enemy Management and Optimization:

Use the grid system to call grid_nearby(x, y, dist=1) (in OpenGL units) to get a list of nearby enemies to the player. This avoids iterating over the entire list of active enemies.
Modify the enemy update and draw functions to accept a sequence of enemy handles, so only enemies within the player's radius are updated and drawn.
For enemy spawning: Create a spawner that generates enemies randomly but avoids overpopulation by spawning only nearby the player. Use the existing enemy grid to fetch nearby enemies for updates/draws—leverage chunks within distance from the player's position to iterate only over relevant enemies.
Update the enemy projectile collision check to account for sprite sizes: Use enemy sprite width (e.g., 16 for gods, 8 for normal enemies) when calculating collision distance.


Nexus Features:

Add a key item to access the nexus.
Implement health regeneration in the nexus: Automatically regen 25 health points every 0.5 seconds when the player is inside.
Add a portal in the nexus that leads to the world map.
Save player position on world map exit, so re-entering places them at the previous spot (or alternatively, randomly spawn on a beach like in the original game).


Storage and Loot:

Create chests for item storage in the nexus (since no vault map exists).
Modify the LootBag class: Remove the despawn countdown timer, prevent deletion if empty, and add a variable to distinguish between loot bags and chests.
Handle chest persistence: Create a global sequence called "chests" to store all chest data and items. Use this to recreate loot bags/chests every time the player enters the nexus (as loot bags are deleted on map load).
For gods: Implement random loot bag drops on death (e.g., every 50 gods killed), containing random items.


UI and Feedback:

Add damage text: When a player projectile hits an enemy, display the damage amount as floating text above the enemy. Use a global damage text list in the enemy projectile update function, storing the enemy handle and damage amount; render it in the enemy health draw function.


Spawning Mechanics:

Create a general enemy spawner: Spawn at random locations, prioritizing gods closer to the map center (calculate distance using half map width/height from center to player).
Check spawn locations: Avoid mountain tiles; use inner/outer perimeter circles—ensure spawn is inside the outer circle but outside the inner one.
Spawn players near beaches: Reference C# source code for beach biome map files (e.g., dat17 for beach data, texture files, projectile data). Use existing enemy/projectile classes and XML for placement outside but nearby the camera view.


Leveling and Stats:

Add leveling system: Increase stats like health, speed, dex, and add a defense stat. Use defense in enemy projectile calculations to reduce player damage taken.
Gain experience points from killing enemies; balance gameplay with high enemy counts.
Add auto health regen for the player: Read regen amount from dat2.xml (reghealth), use a timer to increase health every few seconds.
Load player class data from dat2.xml: Create a new "PlayerTypes" class with slot types, starting equipment, starting/max stats, max/hit points. Set equipment slot types for inventory.


Inventory and Equipment Handling:

In inventory and loot bags: Before allowing drag-and-drop swaps or equipping, check if the equipment slot type matches the item's type.


Collision Detection:

Implement pixel-perfect collision for projectiles: Start with a simple distance check, then use pre-computed alpha masks (8 bits per byte for pixels).
Handle texture atlas: Convert texture positions to bit masks (1 byte for 8 pixels); use OpenGL units (tile width 32, range 0-1). Allocate memory for mask size matching texture; use bit-checking functions (e.g., peek for speed over sequence indexing).


Player Placement Options:

Add an option to position the player at the bottom of the screen (instead of middle) to make fighting gods easier and reduce damage taken.


Code Cleanup:

Tidy up code: Move all global variables to the top of files.


