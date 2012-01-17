module dhe.util.geometry.vector2d;

import std.math;
import dhe.util.geometry.polar;

/**
 * Represents a two-dimensional Vector in the Cartesian coordinate system. 
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

	/**
	 * Does calculations over vector coordinates.
	 *
	 * TODO: Make sure all operators actually work as intended
	 *
	 * Params:
	 *		vector = Another vector object to be used as the second operand
	 * Returns: The result from the operation used.
	 */
	Vector2D opBinary(string op)(Vector2D vector) {
		return Vector2D (mixin("x" ~ op ~ "vector.y"),
						 mixin("y" ~ op ~ "vector.y"));
	}

	/**
	 * Recalculate the coordinates of the Vector into the
	 * Polar coordinate system.
	 *
	 * Params:
	 *		vector = The reference point to pull the Polar origin from
	 *
	 * Returns: A new Polar object pointing to the same coordinate as this
	 *		    object
	 */
	Polar getPolarCoordinate(Vector2D vector) {
		Polar polar = Polar(distance(vector), atan(y/x));
		return polar;
	}

	/**
	 * Calculates the distance between two Vectors.
	 *
	 * Params:
	 *		vector = The Vector to calculate with.
	 *
	 * Returns: The distance between the two vectors.
	 *
	 */
	double distance(Vector2D vector) {
		double vectx = vector.getX() - x;
		double vecty = vector.getY() - y;

		double distance = sqrt((vectx * vectx)) + ((vecty * vecty));
		return distance;
	}

	/**
	 * Turns the current Vector into a unit Vector.
	 *
	 * Returns: A normalized Vector.
	 *
	 */
	void normalize() {
		double length = sqrt((x * x) + (y * y));
		x = x / length;
		y = y / length;
	}
}
