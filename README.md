# Sierpinski triangle

The triangle generated by recursively removing the center quarter piece.
It can also be generated iteratively with the following algorithm:

1. Start from a single point inside the triangle;
2. Randomly choose a vertex;
3. Mark the middle point between the chosen point and the vertex;
4. Return to 2 with the new point.

## Install

Install haxe, then

    $ haxelib install openfl
    $ haxelib run openfl setup
    $ haxelib install HaxePunk

## License

GPLv3, see LICENSE