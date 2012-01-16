module dhe.util.geometry.polar;

import std.math;
import dhe.util.geometry.vector2d;

/**
 * Represents a Vector in the Polar coordinate system
 */
struct Polar {
	private double radius;
	private double angle;

	this(double radius, double degree) {
		this.radius = radius;
		this.angle = angle;
	}

	double getRadius() { return radius; }
	double getAngle() { return angle; }

	void setRadius(double radius) {	this.radius = radius; }
	void setAngle(double angle) { this.angle = angle; }

	Vector opBinary(string op)(Vector vector) {
		return Polar(mixin("radius" ~ op ~ "vector.radius"),
					 mixin("angle" ~ op ~ "vector.angle"));
	}

	Vector2D getTarget() {
		Vector2D vector = Vector2D(radius * cos(angle), radius * sin(angle));
		return vector;
	}

	/**
	 * Calculates the normal coordinate based on this objects coordinate.
	 *
	 * Returns: A Polar of radius=1 and the same angle as this.angle
	 */
	void normalize() {
		radius = 1;
		angle = angle;
	}
}
