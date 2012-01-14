module dhe.util.geometry.size;

struct Size {
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

	Size opBinary(string op)(Size size) {
		return Size(mixin("w" ~ op ~ "size.w"),
					mixin("x" ~ op ~ "vector.y"));
	}
}