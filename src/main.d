module main;

import dhe.util.geometry.all;
import std.stdio;

void main(string args[])
{
	Vector vec = Vector(3, 1);

	writefln("Vector: %s, Point: %s", vec, vec.normalize().getTarget());
	readln();
}
