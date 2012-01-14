module dhe.util.geometry.size2d;

struct Size2D {
	private double w;
	private double h;

	this (double w, double h) {
		this.w = w;
		this.h = h;
	}

	@property double W() { return w; }
	@property W(double value) {  w = value; }
	@property double H() { return h; }
	@property H(double value) {  h = value; }

	Size2D opBinary(string op)(Size2D size) {
		return Size2D(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"));
	}
}