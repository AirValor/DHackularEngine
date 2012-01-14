module main;

import dhe.util.geometry.all;
import std.stdio;

void main(string args[])
{
	Polar vec = Polar(3, 1);

	writefln("PolarPoint: %s, CartesianPoint: %s", vec, vec.normalize().getTarget());
	readln();
}
