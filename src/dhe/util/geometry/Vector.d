module dhe.util.geometry.vector;

import std.math;
import dhe.util.geometry.point;

struct Vector {
	private double distance;
	private double degree;

	this(double distance, double degree) {
		this.distance = distance;
		this.degree = degree;
	}

	Vector opBinary(string op)(Vector vector) {
		return Vector(
					  mixin("distance" ~ op ~ "vector.distance"),
					  mixin("degree" ~ op ~ "vector.degree")
					  );
	}

	Point getTarget() {
		Point point = Point(distance * cos(degree), distance * sin(degree));
		return point;
	}

	Vector normalize() {
		double length = sqrt(pow(distance, 2) + pow(degree, 2));
		distance = distance / length;
		degree = degree / length;
		
		Vector vector = Vector(distance, degree);
		return vector;
	}
}
