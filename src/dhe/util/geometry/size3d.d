module dhe.util.geometry.size3d;

import dhe.util.geometry.size2d;

struct Size3D {
	private double w;
	private double h;
	private double d;

	this(double w, double h, double d) {
		this.w = w;
		this.h = h;
		this.d = d;
	}

	double getW() {  return w; }
	double getH() {  return h; }
	double getD() { return d; }

	void setW(double w) { this.w = w; }
	void setH(double h) { this.h = h; }
	void setD(double d) { this.d = d; }

	Size3D opBinary(string op)(Size3D size) {
		return Size3D(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"),
					mixin("z" ~ op ~ "vector.z"));
	}
}