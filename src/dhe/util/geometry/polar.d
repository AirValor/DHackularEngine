module dhe.util.geometry.polar;

import std.math;
import std.stdio;
import dhe.util.geometry.vector2d;

/**
 * Represents a Vector in the Polar coordinate system
 */
struct Polar {
	private double radius;
	private double angle;

	this(double radius, double angle) {
		while(angle < 0) angle += 360.0;
		while(angle > 359) angle -= 360.0;
		this.radius = radius;
		this.angle = angle;
	}
	unittest{
		Polar temp = Polar(5, 124);
		assert(temp.getRadius() == 5.0, "Basic assignment failed");
		assert(temp.getAngle() == 124.0, "Basic assignment failed");

		Polar temp1 = Polar(5, 3124.0);
		assert(temp1.getAngle() == 244.0, "Couldn't rotate the arrow into the " ~
			   "0-360 degree window");

		Polar temp2 = Polar(5, 364.6);
		assert(temp2.getAngle() > 4.6, "Couldn't rotate a decimal point arrow into the " ~
			   "0-360 degree window");
		assert(temp2.getAngle() < 4.7, "Couldn't rotate a decimal point arrow into the " ~
			   "0-360 degree window");

		Polar temp3 = Polar(5, -4.0);
		assert(temp3.getAngle() == 356.0, "Couldn't rotate a negative arrow into the " ~
			   "0-360 degree window");
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
