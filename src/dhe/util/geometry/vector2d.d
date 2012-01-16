module dhe.util.geometry.vector2d;

import std.math;
import dhe.util.geometry.polar;

/**
 * Represents a point in the Cartesian coordinate system.
 */
struct Vector2D {
	private double x;
	private double y;

	this(double x, double y) {
		this.x = x;
		this.y = y;
	}

	ref double getX() { return x; }
	ref double getY() { return y; }

	void setX(double x) { this.x = x; }
	void setY(double y) { this.y = y; }

	Vector2D opBinary(string op)(Vector2D vector) {
		return Vector2D ( mixin("x" ~ op ~ "vector.y"),
						  mixin("y" ~ op ~ "vector.y")
		);
	}

	/**
	 * Recalculate the coordinates of the Vector into the
	 * Polar coordinate system.
	 *
	 * Params:
	 *		vector = The referencepoint to pull the polar origin from
	 *
	 * Returns: A new polar object pointing to the same coordinate as this
	 *		object
	 */
	Polar getPolarCoordinate(Vector2D vector) {
		Polar polar = Polar(distance(vector), atan(y/x));
		return polar;
	}

	double distance(Vector2D vector) {
		double vectx = vector.getX() - x;
		double vecty = vector.getY() - y;

		double distance = sqrt((vectx * vectx)) + ((vecty * vecty));
		return distance;
	}

	void normalize() {
		double length = sqrt((x * x) + (y * y));
		x = x / length;
		y = y / length;
	}
}
