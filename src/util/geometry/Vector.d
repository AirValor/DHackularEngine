module dhe.util.geometry.vector;

import std.math;
import dhe.util.geometry.point;

struct Vector {
	private double magnitude;
	private double direction;

	this(double magnitude, double direction) {
		this.magnitude = magnitude;
		this.direction = direction;
	}

	Vector opBinary(string op)(Vector vector) {
		return Vector(
					  mixin("magnitude" ~ op ~ "vector.magnitude"),
					  mixin("direction" ~ op ~ "vector.direction")
					  );
	}

	Point getTarget() {
		Point point = Point(magnitude * cos(direction), magnitude * sin(direction));
		return point;
	}

	Vector normalize() {
		double length = sqrt(pow(magnitude, 2) + pow(direction, 2));
		magnitude = magnitude / length;
		direction = direction / length;
		
		Vector vector = Vector(magnitude, direction);
		return vector;
	}
}