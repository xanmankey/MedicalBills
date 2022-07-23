extends Node2D

# A bit of a rework of collisions for this game (I didn't quite understand them at first).
# I'm emitting signals when bodies are entered with a collision type. 
# Collisions are then handled by the player script (the only script where 
# collisions might occur and that has velocity; if necessary, I can assign a 
# different script). There are 3 types of collision signals (push, interact, 
# and pickup) associated w/ diff functions (body_entered, ..., I can't actually 
# find the other functions as signals tho...
# interact and pickup are fundamentally the same, being static and requiring 
# the player to stand outside. Push, on the other hand is weird.

# I wonder if a better way to approach this problem is collision layers
# (although I don't rly think that would work for rigid body collisions);
# also can you apply physics to a static body?
