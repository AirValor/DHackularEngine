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

	@property double W() { return w; }
	@property W(double value) {  w = value; }
	@property double H() { return h; }
	@property H(double value) {  h = value; }
	@property double D() { return d; }
	@property D(double value) {  d = value; }

	Size3D opBinary(string op)(Size3D size) {
		return Size3D(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"),
					mixin("z" ~ op ~ "vector.z"));
	}
}