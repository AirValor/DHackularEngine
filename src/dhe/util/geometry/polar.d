module dhe.util.geometry.polar;

import std.math;
import dhe.util.geometry.vector2d;

struct Polar {
	private double radius;
	private double angle;

	this(double radius, double degree) {
		this.radius = radius;
		this.angle = angle;
	}

	Vector opBinary(string op)(Vector vector) {
		return Polar(
					  mixin("radius" ~ op ~ "vector.radius"),
					  mixin("angle" ~ op ~ "vector.angle")
					  );
	}

	Point getTarget() {
		Point point = Point(radius * cos(angle), radius * sin(angle));
		return point;
	}

	/**
	 * Calculates the normal coordinate based on this objects coordinate.
	 *
	 * Returns: A polar of r=1 and the same angle as this.angle
	 */
	Polar normalize() {
		Polar polar = Polar(1, angle);
		return polar;
	}
}
