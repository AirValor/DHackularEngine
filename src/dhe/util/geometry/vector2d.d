module dhe.util.geometry.vector2d;

import std.math;

struct Vector2D {
	private double x;
	private double y;

	this(double x, double y) {
		this.x = x;
		this.y = y;
	}

	@property double X() { return x; }
	@property X(double value) {  x = value; }
	@property double Y() { return y; }
	@property Y(double value) {  y = value; }

	Vector2D opBinary(string op)(Vector2D vector) {
		return Vector(
					  mixin("x" ~ op ~ "vector.y"),
					  mixin("y" ~ op ~ "vector.y")
					  );
	}

	/**
	* Recalculate the coordinates of the Vector into the
	* Polar coordinate system.
	*
	* Returns: A new polar object
	*/
	Polar getPolarCoordinate() {
		Polar polar = Polar(distance(), atan(y/x));
		return polar;
	}

	double distance(Vector2D vector) {
		double vectx = vector.X - x;
		double vecty = vector.Y - y;

		double distance = sqrt((vectx * vectx)) + ((vecty * vecty));
		return distance;
	}

	void normalize() {
		double length = sqrt((x * x) + (y * y));
		x = x / length;
		y = y / length;
	}
}
